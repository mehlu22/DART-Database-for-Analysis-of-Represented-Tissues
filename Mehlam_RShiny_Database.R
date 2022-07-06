# Create an R Shiny application with gene set data from all the 6 Molecular Signature Databases:
# GO:BP, GO:MF, GO:CC, REACTOME, KEGG, Biocarta
#Data also from tissue specific genes from the Human Protein Atlas
# Features to be added to the R Shiny Application: 
# Search By: tissue name, gene name, MSigDB gene set collection (this is to show coverage of tissue specific gene in the particular database out of 6)
# Filter results by:  percent coverage (on a scale) for when searching in specific databases for GSCs, multiple gene set collections, multiple tissues, multiple genes.
# @Author: Mehlam Saifudeen - ISB Undergraduate Intern
# Date: 5th July, 2022

library(shiny)
library(ggplot2)
library(shiny)
library(DT)
setwd("/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1")
Enriched.filename <- 'rshinytable_Enriched.csv'
Elevated.filename <- 'rshinytable_Elevated.csv'

datadb = read.table(Enriched.filename, header = TRUE, check.names= FALSE, sep = ",")
datadb2 = read.table(Elevated.filename, header = TRUE, check.names= FALSE, sep = ",")



ui <- fluidPage(
  h1(tags$b("DART: Database for Analysis of Represented Tissues")),
  mainPanel(
    tabsetPanel(id = "Database",
      tabPanel("Search by tissue name",
               textInput("mystring", label = h4("Enter Tissue name here"), value = "Enter text..."),
               sliderInput(inputId = "myslider",
                           label = "Filter by Percent coverage",
                           value = 0.5, min = 0, max = 1),
               DT::dataTableOutput("Enriched_table"),
               DT::dataTableOutput("Elevated_table")
      )
  )
  )
  )
  

server <- function(input, output, session) {
  output$value <-renderPrint({ input$text })
  output$Enriched_table = DT::renderDataTable({
    datadb
  
  })
  output$Elevated_table = DT::renderDataTable({
    datadb2
    
  })
}

shinyApp(ui, server)
