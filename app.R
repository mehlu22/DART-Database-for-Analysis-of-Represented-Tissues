# Create an R Shiny application with gene set data from all the 6 Molecular Signature Databases:
# GO:BP, GO:MF, GO:CC, REACTOME, KEGG, Biocarta
# Data also from tissue specific genes from the Human Protein Atlas
# Features to be added to the R Shiny Application:
# Search By: tissue name, gene name, MSigDB gene set collection (this is to show coverage of tissue specific gene in the particular database out of 6)
# Filter results by:  percent coverage (on a scale) for when searching in specific databases for GSCs, multiple gene set collections, multiple tissues, multiple genes.
# @Author: Mehlam Saifudeen - ISB Undergraduate Intern Summer 2022
# Date: 5th July, 2022

library(shiny)
library(ggplot2)
library(shiny)
library(DT)
library(dplyr)
library(shinythemes)
library(pivottabler)
#setwd("/Users/Admin/Desktop/R_course ISB Project/Code/HPA_Tissue_Lists/HPA_Tissues_10.1")
Enriched.filename <- 'rshinytable_Enriched.csv'
Elevated.filename <- 'rshinytable_Elevated.csv'

datadb = as.data.frame(read.table(Enriched.filename, header = TRUE, check.names= FALSE, sep = ","))
datadb2 = as.data.frame(read.table(Elevated.filename, header = TRUE, check.names= FALSE, sep = ","))

ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel(
    h1(img(src="dart_image2.jpg", height = '150px', width = '120px'), tags$b("  DART: Database for Analysis of Represented Tissues   "),img(src="dart_image1.jpg", height = '150px', width = '120px'), align = "center", col = "6")),
  mainPanel(
    tabsetPanel(id = "Database",
                tabPanel("README",
                         style = "font-size: 25px", 
                         tags$li("DART is a database that displays tissue specificity data for gene set collections to facilitate proper selection of databases for pathway enrichment analysis"),
                         tags$br(),
                         tags$li("DART contains tissue specific gene coverage for 6 of the most frequently used gene set collections used for pathway enrichment analysis."),
                         tags$br(),
                         tags$li("Tissue specificity annotations are derived from the Human Protein Atlas. 
                                 Tissue enriched genes are defined as having atleast five fold higher mRNA levels in a particular tissue as compared to all other tissues. 
                                 Tissue elevated genes are defined as include three subcategories: Tissue-enriched, group-enriched, which includes genes with at least five-fold higher average mRNA level in a group of 2-5 tissues compared to any other tissue, and tissue-enhanced, which contains genes with at least five-fold higher mRNA level in a particular tissue compared to the average level in all other tissues."),
                         tags$a(href = "https://www.proteinatlas.org/", "Human Protein Atlas"),
                         tags$br(),
                         tags$li("The separate tabs display data of the tissue elevated and tissue enriched genes."),
                         tags$br(),
                         tags$li("Searchable features include:
                                  1) Tissue Name, 2) Gene Symbol, 3) Molecular Gene Set Collection name (GO:BP, GO:MF, GO:CC, KEGG, Reactome, BIOCARTA."),
                         tags$br(),
                         tags$li("The elevated and enriched tissues tabs display the fractional coverage of each tissue within each of the 6 gene set collection databases."),
                         tags$br(),
                         tags$li("The “Query” tab allows a user to input a csv file that contains a list of genes of interest in a single column named genes. DART displays the tissue coverage for all gene set collection databases to allow selection of the best one for pathway enrichment analysis in a particular tissue."),
                         tags$br(),
                         tags$li("Author: Mehlam Saifudeen (Institute for Systems Biology Intern) - For inquiries please email mms330@case.edu")),
                tabPanel("Enriched Genes",         
                         fluidRow(
                           column(4, 
                                  selectInput("tissue",
                                              "Tissue Name: ",
                                              c("All",
                                                unique(as.character(datadb$Tissue))), width = '300px', multiple=TRUE, selectize=T, selected = "All")
                           ),
                           column(4,
                                  selectInput("gene",
                                              "Gene Name: ",
                                              c("All",
                                                unique(as.character(datadb$Enriched_Gene_symbol))),  width = '300px', multiple=TRUE, selectize=TRUE, selected = "All")
                           ),
                           column(4, selectInput("msigdb", "Gene Set Collection:",
                                                 c("All", "GO_BP", "GO_MF", "GO_CC", "REACTOME","KEGG", "BIOCARTA" ),  width = '300px', multiple=TRUE, selectize=TRUE, selected = "All")),
                           
                           #sliderInput(inputId = "myslider",
                           #           label = "Filter by Percent coverage",
                           #          min = 0, max = 1, value = c(0.5, 0.7))
                         ),
                         DT::dataTableOutput("Enriched_Table"),
                         downloadButton(outputId = "mydownload1", label = "Download Table", icon = icon("list-alt"))
                ),
                tabPanel("Enriched Genes Tissues",
                         style = "font-size: 25px",
                         ("These pie charts show the fractional coverage of each tissue in each of the 6 Molecular Signature Databases: "),
                         tags$br(),
                         tags$br(),
                         img(src="gobp.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="gomf.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="gocc.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="reactome.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="kegg.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="biocarta.png", height = '650px', width = '1320px')),
                tabPanel("Elevated Genes",
                         fluidRow(
                           column(4, 
                                  selectInput("tissue1",
                                              "Tissue Name:",
                                              c("All",
                                                unique(as.character(datadb2$Tissue))),  width = '300px', multiple=TRUE, selectize=TRUE, selected = "All"),
                           ),
                           column(4, 
                                  selectInput("gene1",
                                              "Gene Name:",
                                              c("All",
                                                unique(as.character(datadb2$Elevated_Gene_symbol))),  width = '300px', multiple=TRUE, selectize=TRUE, selected = "All")
                           ),
                           column(4, selectInput("msigdb1", "Gene Set Collection:",
                                                 c("All", "GO_BP", "GO_MF", "GO_CC", "REACTOME","KEGG", "BIOCARTA"),  width = '300px', multiple=TRUE, selectize=TRUE, selected = "All")),
                           
                           # sliderInput(inputId = "myslider",
                           #            label = "Filter by Percent coverage",
                           #           min = 0, max = 1, value = c(0.5, 0.7))
                         ),
                         DT::dataTableOutput("Elevated_Table"),
                         downloadButton(outputId = "mydownload", label = "Download Table", icon = icon("list-alt"))
                ),
                tabPanel("Elevated Genes Tissues",
                         style = "font-size: 25px",
                         "These pie charts show the fractional coverage of each tissue in each of the 6 Molecular Signature Databases: ",
                         tags$br(),
                         tags$br(),
                         img(src="gobp1.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="gomf1.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="gocc1.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="reactome1.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="kegg1.png", height = '650px', width = '1320px'),
                         tags$br(),
                         tags$br(),
                         img(src="biocarta1.png", height = '650px', width = '1320px')),
                tabPanel("Gene File Input",
                         sidebarLayout(
                           sidebarPanel(
                             
                             fileInput("file1", label = h5 ("Attach csv file with list of enriched and elevated genes in a single column named genes"), accept = ".csv", buttonLabel = "Insert a gene set file"),
                             selectInput("tissue", label = h5("Tissue Name"),
                                         choices = c("All",
                                                     unique(as.character(datadb2$Tissue))), width = '300px', multiple=TRUE, selectize=TRUE)
                             #selectInput("", label = h5("Columns"),
                             #           choices = list("Train Category" = "TrainCategory",
                             #                         "TOC" = "TOC",
                             #                        "Power Type" = "PowerType"), selected = "TrainCategory")
                           ),
                           
                           mainPanel(
                             pivottablerOutput('pvt')
                           ))
                )
    )
  )
)

server <- function(input, output, session)
{
  Enriched_Table <- reactive({
    data <- datadb
    ifelse(input$tissue != "All", data <- data[data$Tissue == input$tissue, ], data)
    ifelse(input$gene != "All",  data <- data[data$Enriched_Gene_symbol == input$gene, ],  data)
    ifelse(input$msigdb == "GO_BP", data <- data[data$GO_BP, ], data)
    ifelse(input$msigdb == "GO_CC", data <- data[data$GO_CC, ], data)
    ifelse(input$msigdb == "GO_MF", data <- data[data$GO_MF, ], data)
    ifelse(input$msigdb == "REACTOME", data <- data[data$REACTOME, ], data)
    ifelse(input$msigdb == "KEGG", data <- data[data$KEGG, ], data)
    ifelse(input$msigdb == "BIOCARTA", data <- data[data$BIOCARTA, ], data)
    return(data)
  })
  
  
  output$Enriched_Table <- DT::renderDataTable({
    Enriched_Table()
  },
  options = list(paging = T),
  filter = "top")
  
  output$mydownload1 <- downloadHandler(
    filename = function(){
      "Enriched_Table_data.csv"},
    content = function(file) {
      write.csv(Enriched_Table(), file, row.names = F)})
  
  Elevated_Table <- reactive({
    datan <- datadb2
    ifelse(input$tissue1 != "All", datan <- datan[datan$Tissue == input$tissue1, ], datan)
    ifelse(input$gene1 != "All",  datan <- datan[datan$Elevated_Gene_symbol == input$gene1, ], datan)
    ifelse(input$msigdb1 == "GO_BP", datan <- datan[datan$GO_BP, ], datan)
    ifelse(input$msigdb1 == "GO_CC", datan <- datan[datan$GO_CC, ], datan)
    ifelse(input$msigdb1 == "GO_MF", datan <- datan[datan$GO_MF, ], datan)
    ifelse(input$msigdb1 == "REACTOME", datan <- datan[datan$REACTOME, ], datan)
    ifelse(input$msigdb1 == "KEGG", datan <- datan[datan$KEGG, ], datan)
    ifelse(input$msigdb1 == "BIOCARTA", datan <- datan[datan$BIOCARTA, ], datan)
    return(datan)
  })
  
  output$Elevated_Table <- DT::renderDataTable({
    Elevated_Table()
  },
  options = list(paging = T),
  filter = "top")
  
  output$mydownload <- downloadHandler(
    filename = function(){
      "Elevated_Table.csv"},
    content = function(file) {
      write.csv(Elevated_Table(), file)})
  
  fileOutput_enriched <- reactive({
    data2 <- datadb
    data3 <- datadb2
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    
    tbl <- as.data.frame(suppressMessages(read.table(inFile$datapath, header = TRUE, check.names= FALSE, sep = ",")))
    ifelse(data2$Enriched_Gene_symbol == tbl$genes, data2 <- data2[data2$Enriched_Gene_symbol == tbl$genes, ], data3 <- data3[data3$Elevated_Gene_symbol == tbl$genes, ])
    
    #final <- bind_rows(data2, data3)
    #final_tissues <- as.data.frame(unique(final$Tissue))
    return(data2)
  })
  
  fileOutput_elevated <- reactive({
    data2 <- datadb
    data3 <- datadb2
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    
    tbl <- as.data.frame(suppressMessages(read.table(inFile$datapath, header = TRUE, check.names= FALSE, sep = ",")))
    ifelse(data2$Enriched_Gene_symbol == tbl$genes, data2 <- data2[data2$Enriched_Gene_symbol == tbl$genes, ], data3 <- data3[data3$Elevated_Gene_symbol == tbl$genes, ])
    
    #final <- bind_rows(data2, data3)
    #final_tissues <- as.data.frame(unique(final$Tissue))
    return(data3)
  })
  
  output$UserTable1 <- DT::renderDataTable({
    fileOutput_enriched()
  }, filter = "top")
  
  output$UserTable2 <- DT::renderDataTable({
    fileOutput_elevated()
  }, filter = "top")
  
  output$pvt <- renderPivottabler({
    pt <- PivotTable$new()
    data2 <- (datadb)
    data3 <- (datadb2)
    
    
    databases <- data.frame(databases = c("GO_BP", "GO_MF", "GO_CC", "REACTOME", "KEGG", "BIOCARTA"))
    type <- data.frame(type_tissue = c("Enriched", "Elevated"))
    
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    
    tbl <- as.data.frame(suppressMessages(read.table(inFile$datapath, header = TRUE, check.names= FALSE, sep = ",")))
    ifelse(data2$Enriched_Gene_symbol == tbl$genes, data2 <- data2[data2$Enriched_Gene_symbol == tbl$genes, ], data3 <- data3[data3$Elevated_Gene_symbol == tbl$genes, ])
    
    final <- bind_rows(data2, data3)
    final <- merge(final, databases, all.x = T)
    final <- merge(final, type, all.x = T)
    
    pt$addData(final)
    pt$addRowDataGroups("Tissue", addTotal = F)
    pt$addColumnDataGroups("databases", addTotal = F)
    pt$addColumnDataGroups("type_tissue", addTotal = F)
    pt$defineCalculation(calculationName = "TotalTrue", summariseExpression = "n()")
    pt$renderPivot()
  })
  
  
}

shinyApp(ui, server)