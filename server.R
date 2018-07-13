library(shiny)

source('init.R')


shinyServer(function(input, output, session)
{
    output$asignaturas <- renderDT(
    {
        curso <- input$curso
        ## URL de la GA
        asignaturas[, Guia := paste0('<a href="',
                                     GAurl(Codigo,
                                           CodTitulacion,
                                           Semestre,
                                           curso),
                                     '" target=_blank>',
                                     Codigo, '</a>')]
        asignaturas[, .(
            Titulacion,
            Asignatura,
            Semestre,
            Guia)]
    },
    rownames = FALSE,
    colnames = c('Titulación',
                 'Asignatura',
                 'Semestre',
                 'Guía'),
    escape = FALSE,
    filter = 'top',
    options = list(
        autoWidth = TRUE,
        pageLength = 5,
        dom = 'tp',
        language = list(url = '//cdn.datatables.net/plug-ins/1.10.7/i18n/Spanish.json'))
    )
})
