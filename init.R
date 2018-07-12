library(data.table)
library(DT)

source('../misc/funciones.R')
source('../misc/defs.R')
asignaturas <- fread('../misc/asignaturas.csv')


## No tengo en cuenta los dobles grados ni los másteres fuera de la
## ETSIDI
codTitulaciones <- c(grados, masters)
codTitulaciones <- codTitulaciones[!(codTitulaciones %in%
                                     c("56DM", "56EE"))]
asignaturas <- asignaturas[Titulacion %in% codTitulaciones]

## Uso el código de la titulación y añado el nombre del título para la
## tabla
asignaturas[, CodTitulacion := Titulacion]
idxCodTit <- match(asignaturas$Titulacion, codTitulaciones)
titulaciones <- names(codTitulaciones)
asignaturas[, Titulacion := factor(titulaciones)[idxCodTit]]

## Asignaturas en formato título (no mayúsculas)
asignaturas[, Asignatura := factor(titlecase(Asignatura))]

## No incluyo el TFG/TFM
asignaturas <- asignaturas[!grepl("Trabajo Fin", Asignatura)]

## URL de la GA
asignaturas[, Guia := paste0('<a href="',
                            GAurl(Codigo,
                                  CodTitulacion,
                                  Semestre,
                                  cursoActual),
                            '" target=_blank>',
                            Codigo, '</a>')]
