#!/bin/bash

# Directorio donde están las imágenes de referencia
directorio="./generated_images"

# Nombre del archivo de resultados
archivo_resultados="./resultados_promedios.txt"
resultados_promedios_iteraciones="./resultados_promedios_iteraciones.txt"
rm $archivo_resultados
rm $resultados_promedios_iteraciones

# Inicialización de arrays para almacenar las sumas y conteos de cada valor de imagen "noise"
declare -A sumas
declare -A contadores

# Array para almacenar todas las salidas individuales del comando fvvdp
declare -A salidas_individuales

# Recorremos las imágenes de referencia para determinar los valores de "noise"
for imagen_base in "$directorio"/image_*_base.jpg; do
    # Obtenemos el valor de "noise" de la imagen de referencia
    valor=$(echo "$imagen_base" | sed 's/.*image_\([0-9]*\)_base\.jpg/\1/')
    
    # Inicializamos la suma y el contador para este valor de "noise"
    sumas["$valor"]=0
    contadores["$valor"]=0
done

# Recorremos los subdirectorios en busca de imágenes de test
for carpeta in "$directorio"/*; do

    echo "-------------------------------------------------------------------------------------------------" >> "$resultados_promedios_iteraciones"
    echo "Procesando imágenes en la carpeta: $carpeta" >> "$resultados_promedios_iteraciones"
    echo "-------------------------------------------------------------------------------------------------"
    echo "Procesando imágenes en la carpeta: $carpeta"
    
    # Recorremos las imágenes de test en la carpeta actual
    for imagen_test in "$carpeta"/image_*_noise.jpg; do
        # Obtenemos el valor de "noise" de la imagen de prueba
        valor=$(echo "$imagen_test" | sed 's/.*image_\([0-9]*\)_noise\.jpg/\1/')
        
        # Construimos el nombre de la imagen de referencia
        imagen_referencia="$carpeta/image_${valor}_base.jpg"
        
        # Verificamos si existe la imagen de referencia
        if [ -f "$imagen_referencia" ]; then
            # Ejecutamos el comando fvvdp y guardamos la salida
            salida=$(fvvdp --test "$imagen_test" --ref "$imagen_referencia" --display standard_fhd | grep -oP 'FovVideoVDP=\K\d+\.\d+')
            
            # Guardamos la salida individual en el array
            salidas_individuales["$valor"]+=" $salida"
            
            echo "********* Imagen $valor de la carpeta $carpeta, JDD: $salida"
            echo "Imagen $valor de la carpeta $carpeta, JOD: $salida" >> "$resultados_promedios_iteraciones"
        else
            echo "No se encontró la imagen de referencia para $imagen_test"
            echo "No se encontró la imagen de referencia para $imagen_test" >> "$resultados_promedios_iteraciones"
        fi
    done
done

# Calculamos los promedios y desviaciones estándar de la salida del comando fvvdp para cada valor de "noise"
for valor in "${!salidas_individuales[@]}"; do
    # Extraemos todas las salidas individuales para este valor de "noise"
    todas_las_salidas="${salidas_individuales[$valor]}"
    
    # Convertimos las salidas en una matriz
    read -ra salidas_array <<< "$todas_las_salidas"
    
    # Inicializamos la suma y el contador para calcular el promedio
    suma=0
    contador=0
    
    # Calculamos la suma de todas las salidas y el número total de salidas
    for salida in "${salidas_array[@]}"; do
        suma=$(awk "BEGIN {print $suma + $salida}")
        contador=$((contador + 1))
    done
    
    # Calculamos el promedio
    promedio=$(awk "BEGIN {print $suma / $contador}")
    
    # Guardamos el promedio en el array
    promedios["$valor"]=$promedio
    
    # Inicializamos la suma de los cuadrados de las diferencias
    suma_cuadrados_diff=0
    
    # Calculamos la suma de los cuadrados de las diferencias para calcular la desviación estándar
    for salida in "${salidas_array[@]}"; do
        suma_cuadrados_diff=$(awk "BEGIN {print $suma_cuadrados_diff + ($salida - $promedio)^2}")
    done
    
    # Calculamos la desviación estándar
    desviacion_estandar=$(awk "BEGIN {print sqrt($suma_cuadrados_diff / $contador)}")
    
    # Guardamos la desviación estándar en el array
    desviaciones_estandar["$valor"]=$desviacion_estandar
done

# Escribimos los resultados en el archivo de resultados
for valor in "${!promedios[@]}"; do
    echo "El promedio de las comparaciones para el valor de imagen noise $valor es: ${promedios[$valor]}, y la desviación estándar es: ${desviaciones_estandar[$valor]}" >> "$archivo_resultados"
    echo "El promedio de las comparaciones para el valor de imagen noise $valor es: ${promedios[$valor]}, y la desviación estándar es: ${desviaciones_estandar[$valor]}" >> "$resultados_promedios_iteraciones"
done
