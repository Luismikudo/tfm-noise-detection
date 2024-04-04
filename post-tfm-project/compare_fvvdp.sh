#!/bin/bash

# Directorio donde están las imágenes
directorio="./ImagenesGeneradas"
# Nombre del archivo de resultados
archivo_resultados="./resultados.txt"

# Recorremos el directorio en busca de imágenes de test
for imagen_test in "$directorio"/image_*_with_incremented_noise.jpg; do
    # Obtenemos el número de la imagen de test
    numero=$(echo "$imagen_test" | sed 's/.*image_\([0-9]*\)_with_incremented_noise\.jpg/\1/')

    # Construimos el nombre de la imagen de referencia
    imagen_referencia="$directorio/image_${numero}_without_incremented_noise.jpg"

    # Verificamos si existe la imagen de referencia
    if [ -f "$imagen_referencia" ]; then
        # Ejecutamos el comando fvvdp y guardamos la salida en el archivo de resultados
        salida=$(fvvdp --test "$imagen_test" --ref "$imagen_referencia" --display standard_fhd)
        echo "La comparación de la imagen $imagen_test con la imagen $imagen_referencia da este resultado: $salida" >> "$archivo_resultados"
    else
        echo "No se encontró la imagen de referencia para $imagen_test"
    fi
done
