library(shiny)
library(shinyjs)

source('init.R')


## Cabecera con logos
header <- fluidRow(
    column(4, align = 'center', img(src = logoUPM, width = 72)),
    column(4, align = 'center',
           h2("Guías de Asignatura"),
           h5("Subdirección de Ordenación Académica")),
    column(4, align = 'center', img(src = logoETSIDI, width = 72))
)

intro <- div(id = 'selector',
             fluidRow(
                 column(12,
                        wellPanel(
                            p('Esta página publica las Guías de Asignatura de las titulaciones impartidas en la ETSIDI.',
                              'Usa una o varias listas de selección para filtrar el contenido de la tabla que se muestra a continuación.',
                              'Puedes recorrer las listas de selección o escribir varias letras para delimitar la búsqueda.',
                              'En cada selector se pueden elegir varias opciones simultáneamente.',
                              'Emplea la tecla "Retroceso" o "Suprimir" para eliminar las opciones seleccionadas.',
                              'Puedes reordenar la tabla pulsando en el título de la columna correspondiente.'
                         )))))
tabla <- div(id = 'tabla',
             fluidRow(dtOutput("asignaturas"))
             )

## UI completa
shinyUI(
    fluidPage(
        useShinyjs(),
        includeCSS("styles.css"),
        header,
        intro,
        tabla
    )
)

