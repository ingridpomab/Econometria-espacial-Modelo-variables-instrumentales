# Evaluación cantonal de la mortalidad infantil en Ecuador: Modelo de variables instrumentales

## Resumen

Este proyecto examina la mortalidad infantil cantonal en Ecuador (2014) mediante el método de **variables instrumentales**, evaluando la relación entre el salario de las madres, la calidad de los servicios de salud y la tasa de mortalidad infantil (TMI). Se encontró evidencia de endogeneidad entre las variables salario y servicio de salud, tratada mediante los estimadores **2SLS**, **LIML** y **GMM**, logrando reducir la TMI estimada en un **59.8%**. Los resultados muestran que el salario, la calidad de los servicios de salud, el sector laboral, los controles prenatales, el área de residencia y la calidad del agua influyen negativamente en la mortalidad infantil, mientras que la edad, el estado civil (madre soltera) y la discapacidad la incrementan.

## Motivación

La mortalidad infantil es un indicador clave de desarrollo socioeconómico. En Ecuador pasó de 12.7 muertes por cada 1000 nacimientos (1990–2015) a 14 muertes en 2016. El proyecto se enmarca en la teoría del desarrollo de Amartya Sen y Brundtland (1999), que sostiene que la inversión en la infancia es clave para romper los ciclos de pobreza, y busca determinar si existe un problema de endogeneidad entre salario y acceso a servicios de salud de calidad para tratarlo con métodos de variables instrumentales.

## Datos

- **Fuente:** Encuesta de Condiciones de Vida (ECV) 2013–2014, y fórmula de cálculo del INEC para la tasa de mortalidad infantil (nacidos vivos y defunciones, 2014).
- **Unidad de análisis:** 142 cantones de Ecuador (de 118 cantones con datos disponibles, con variación según género y edad).
- **Periodo:** 2014.

### Variables

| Variable | Símbolo | Descripción | Medición |
|---|---|---|---|
| Mortalidad infantil | MI | Defunciones de menores de 1 año / nacidos vivos × 1000 | Tasa cantonal (%) |
| Salario madres | Sm | Ingreso salarial de las madres | Dólares |
| Calidad servicio de salud | Css | Calificación del trato en instituciones de salud pública | 1 = bueno/muy bueno, 0 = resto |
| Estado civil | Ec | Madre soltera | 1 = soltera, 0 = resto |
| Discapacidad | Dis | Presencia de discapacidad | 1 = sí, 0 = no |
| Edad | Edad | Edad de la madre | Años |
| Control de embarazo | Ce | Seguimiento prenatal | 1 = sí, 0 = no |
| Sector de trabajo | Sector | Tipo de sector laboral | Particular / Calle / Propio |
| Calidad del agua | Cagua | Contaminación del agua | 1 = sí, 0 = no |
| Área | Area | Zona de residencia | 1 = urbano, 0 = rural |

## Metodología

1. Análisis exploratorio y estadísticos descriptivos (142 observaciones cantonales).
2. Análisis de correlación entre TMI y variables explicativas.
3. Modelo empírico de regresión múltiple (Modelos 1–5, MCO) para identificar significancia de variables.
4. Tratamiento de la endogeneidad salario–servicio de salud mediante variables instrumentales:
   - **2SLS** (mínimos cuadrados en dos etapas)
   - **LIML** (máxima verosimilitud con información limitada)
   - **GMM** (método generalizado de momentos)

Ecuación estimada:

```
MIᵢ = α0 + α1·Salarioᵢ + α2·Servicioᵢ + α3·Discapacidadᵢ + α4·Edadᵢ + α5·Controlᵢ
      + α6·Empleoᵢ + α7·Aguaᵢ + α8·Areaᵢ + α9·EstadoCivilᵢ + εᵢ
```

## Resultados principales

- El **Modelo 5** (regresión múltiple completa) explica el 2.6% de la variación en la TMI cantonal.
- El salario tiene efecto negativo sobre la TMI; al corregir endogeneidad (2SLS/LIML), el efecto se vuelve significativo y negativo.
- La calidad de servicios de salud reduce la TMI en 5.07 veces frente a cantones sin acceso.
- Ser madre soltera incrementa la probabilidad de mortalidad infantil en 1.75 veces frente a madres casadas.
- La discapacidad de la madre incrementa 5.81 veces la probabilidad de mortalidad infantil.
- No realizar controles prenatales incrementa 5.02 veces el riesgo, frente a quienes sí los realizan.
- Vivir en área rural incrementa 0.55 veces la probabilidad de mortalidad infantil frente al área urbana.
- Las pruebas de endogeneidad (2SLS y LIML) permitieron reducir la TMI estimada en **59.8%**.

## Conclusiones y recomendaciones de política

Los resultados evidencian que la inversión pública en salud y educación no fue suficiente en 2014, especialmente en zonas rurales. Se recomienda:
- Incrementar el presupuesto en salud y educación en zonas rurales.
- Fortalecer programas de educación sexual para prevenir embarazos adolescentes.
- Generar empleo formal con salarios dignos para madres de familia.
- Actualizar los sistemas estadísticos nacionales, dado que la información desactualizada limita el diseño de políticas públicas efectivas.

## Estructura del repositorio

```
├── ECV 2014/               # Base de la ECV 2013-2014 (csv)*
├── Do/            # Códigos en R
│   ├── 01_limpieza.R
│   ├── 02_analisis_exploratorio.R
│   ├── 03_modelo_iv.R          # 2SLS, LIML, GMM
│   └── 04_resultados.R
├── output/             # Tablas y gráficos (mapas cantonales, correlaciones)
├── README.md
```
*Provienen de la Encuesta de Condiciones de Vida (ECV) 2013-2014 del INEC.

Descarga oficial: (https://www.ecuadorencifras.gob.ec//documentos/web-inec/ECV/ECV_2015/)

Nota: El archivo no se incluye por su tamaño. Descárgalo desde el enlace oficial y colócalo en la carpeta `ECV 2014/` antes de ejecutar los scripts.

## Requisitos

- R (versión recomendada: 4.x)
- Paquetes principales:

```r
install.packages(c("sf", "spdep", "AER", "ivreg", "dplyr", "ggplot2"))
```

*(`AER`/`ivreg` para 2SLS y LIML/GMM en R; ajusta según los paquetes que realmente usaste.)*

## Cómo ejecutar

```r
git clone https://github.com/ingridpomab/evaluacion-mortalidad-infantil.git
# Abrir en RStudio y ejecutar en orden los scripts de la carpeta scripts/
```

## Referencia del estudio original

Poma, I. Evaluación cantonal de la mortalidad infantil en Ecuador durante 2014, utilizando modelos de variables instrumentales. Universidad Nacional de Loja.

## Licencia

#Propiedad autora: Ingrid Poma
*(opcional: MIT, CC-BY, etc.)*
