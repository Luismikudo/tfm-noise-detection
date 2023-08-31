<h1 align="center"> Scripts para la detección de los umbrales </h1>

---
Autor:
- [Luis Miguel Calvo Magaz](https://www.linkedin.com/in/luis-miguel-calvo-magaz/)

## Tabla de contenidos:
---

- [lenna_noises.ipynb](#generación-de-ruido-sobre-la-imagen-de-lenna)
- [load_one_experiment.ipynb](#carga-de-datos-para-un-experimento)
- [calcs_all_participants.ipynb](#cáculos-para-todos-los-participantes)
- [data_calcs.ipynb](#cálculo-de-jnd-para-ugr-y-upv)
- [ugr_upv_average.ipynb](#promedio-de-ugr-y-upv)
- [tests.ipynb](#tests)
- [outliers.ipynb](#outliers)
- [stats_calcs.ipynb](#estadísticas)
- [plots_regression.ipynb](#gráficos-de-regresión)
- [plots_no_intercept.ipynb](#gráficos-de-regresión-sin-intercept)
- [split_by_group.ipynb](#división-por-grupos)
- [plots_by_user_type.ipynb](#gráficos-divididos-por-grupos)

## Generación de ruido sobre la imagen de Lenna
---
En este script [lenna_noises.ipynb](/lenna_noises.ipynb) se realizan los tratamientos de la imagen de Lenna, añadiendo los ruidos Gaussianos, Sal y pimienta e uniforme que posteriormente se han utilizado en la sección de Lenna de la memoria. 

## Carga de datos para un experimento
---
En el script [load_one_experiment.ipynb](/load_one_experiment.ipynb) se cargan los datos de un experimento determinado para posteriormente calcular su JND y las curvas psicométricas (normales acumuladas) para las combinaciones de ruido base y luminancia de ese único experimento.

## Cáculos para todos los participantes
---
En el script [calcs_all_participants.ipynb](/calcs_all_participants.ipynb) se realizan los cáculos para todos los participantes del experimento, promediando los datos de sus sesiones experiementales individualmente, al igual que en el script anterior se calcula el JND y las curvas psicométricas (normales acumuladas) para las combinaciones de ruido base y luminancia para cada participante.

## Cálculo de JND para UGR y UPV
---
En el script [data_calcs.ipynb](/data_calcs.ipynb) se exportan las variables de mean_result y mean_std para las universidades de Granada, Politécnica de Valencia y en total.
- **mean_result_{universidad}.npy** contiene los promedios de la tasa de acierto para cada combinación de ruido base y luminancia en las 10 repeticiones por cada nivel.
- **mean_std_{universidad}.npy** almacena los datos del (ruido base, media del JND, deviación típica del JND) para cada combinación de ruido base y luminancia.

Estas variables se utilizarán posteriormente en otros scripts como el de [plots_regression.ipynb](/plots_regression.ipynb) para realizar gráficos.

## Promedio de UGR y UPV
---
En el script [ugr_upv_average.ipynb](/ugr_upv_average.ipynb) se realizan los gráficos del JND y las curvas psicométricas (normales acumuladas) para las combinaciones de ruido base y luminancia en el promedio de Granada y Valencia individualmente y posteriormente en conjunto.

## Tests
---
En el script [tests.ipynb](/tests.ipynb) se realizan los tests que contrastan si hay diferencias significativas entre los grupos de UPV y UGR y determinar si estadísticamente hablando tendría sentido juntarlos en un único dataset.

## Outliers
---
En el script [outliers.ipynb](/outliers.ipynb) se comprueba si existen outliers en los datos de UGR y UPV comparando con el resto de voluntarios de la misma universidad

## Estadísticas
---
En el script [stats_calcs.ipynb](/stats_calcs.ipynb) se calculan las estadísiticas de los participantes por edad, género y nivel de experiencia.

## Gráficos de regresión
---
En el script [plots_regression.ipynb](/plots_regression.ipynb) se realizan las gráficas de regresión para el umbral de detección y el JND

## Gráficos de regresión sin intercept
---
En el script [plots_no_intercept.ipynb](/plots_no_intercept.ipynb) se realizan las gráficas de regresión para el umbral de detección y el JND pero forzando que el intercept de las mismas sea igual a 0.

## División por grupos
---
En el script [split_by_group.ipynb](/split_by_group.ipynb) se dividen a los participantes según su edad, género y nivel de experiencia.
Crea un diccionario ["mean_result_agrupado.pkl"](/variables/mean_result_agrupado.pkl) en el que se almacenan los promedios de las tasas de acierto filtrando por las estadísitcas previamente calculadas.

Este diccionario se utilizará posteriormente en otros scripts como el de [plots_by_user_type.ipynb](/plots_by_user_type.ipynb) para realizar gráficos.

## Gráficos divididos por grupos
---
En el script [plots_by_user_type.ipynb](/plots_by_user_type.ipynb) se utiliza el diccionario ["mean_result_agrupado.pkl"](/variables/mean_result_agrupado.pkl) en el que se almacenan los promedios de las tasas de acierto filtrando por las estadísitcas previamente calculadas para realizar los gráficos de regresión pero esta vez por grupos.
