library(shiny)
library(shinyjs)

source('init.R')


shinyServer(function(input, output, session)
{

    output$asignaturas <- renderDT(
        asignaturas[, .(
            Titulacion,
            Asignatura,
            Semestre,
            Guia)],
        rownames = FALSE,
        colnames = c('Titulación',
                     'Asignatura',
                     'Semestre',
                     'Guía'),
        escape = FALSE,
        filter = 'top',
        options = list(
            autoWidth = TRUE,
            pageLength = 6,
            dom = 'tp',
            language = list(url = '//cdn.datatables.net/plug-ins/1.10.7/i18n/Spanish.json'))
    )
    
})
