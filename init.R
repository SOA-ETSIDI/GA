library(data.table)
library(DT)

dtOutput <- DT::dataTableOutput
renderDT <- DT::renderDataTable

source('../misc/funciones.R')
source('../misc/defs.R')
asignaturas <- fread('../misc/asignaturas.csv')

inicio <- as.numeric(substring(cursoActual, 1, 4))
if (month(Sys.Date()) == 7) ## En julio están disponibles las guías del curso siguiente
    inicio <- inicio + 1
final <- 2015 ## En GAUSS están disponibles las guías desde el curso 2015-16
cursosNum <- inicio:final 
cursos <- paste(cursosNum, (cursosNum - 2000) + 1, sep = '-')

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

