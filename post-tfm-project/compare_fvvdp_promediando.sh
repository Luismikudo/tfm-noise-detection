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

    echo "-------------------------------------------------------------------------------------------------" >> $resultados_promedios_iteraciones
    echo "Procesando imágenes en la carpeta: $carpeta" >> $resultados_promedios_iteraciones
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
            # Ejecutamos el comando fvvdp y sumamos el resultado a la suma total para este valor de "noise"
            salida=$(fvvdp --test "$imagen_test" --ref "$imagen_referencia" --display standard_fhd | grep -oP 'FovVideoVDP=\K\d+\.\d+')
            sumas["$valor"]=$(awk "BEGIN {print ${sumas[$valor]} + $salida}")
            contadores["$valor"]=$((contadores[$valor] + 1))
            echo "********* Imagen $valor de la carpeta $carpeta, JDD: $salida"
            echo "Imagen $valor de la carpeta $carpeta, JOD: $salida" >> $resultados_promedios_iteraciones
        else
            echo "No se encontró la imagen de referencia para $imagen_test"
            echo "No se encontró la imagen de referencia para $imagen_test" >> $resultados_promedios_iteraciones
        fi
    done
done

# Calculamos los promedios de la salida del comando fvvdp para cada valor de "noise"
for valor in "${!sumas[@]}"; do
    if [ "${contadores[$valor]}" -gt 0 ]; then
        promedio=$(awk "BEGIN {print ${sumas[$valor]} / ${contadores[$valor]}}")
        echo "El promedio de las comparaciones para el valor de imagen noise $valor es: $promedio" >> "$archivo_resultados"
        echo "El promedio de las comparaciones para el valor de imagen noise $valor es: $promedio" >> $resultados_promedios_iteraciones
    else
        echo "No se encontraron imágenes de prueba para el valor de imagen noise $valor"
        echo "No se encontraron imágenes de prueba para el valor de imagen noise $valor" >> $resultados_promedios_iteraciones
    fi
done