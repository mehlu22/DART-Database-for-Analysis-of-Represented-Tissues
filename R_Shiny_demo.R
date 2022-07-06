#R Shiny demo from tutorial video

#A basic shiny app
## A basic shiny app

#Section 2 Code
library(shiny)

server = function(input, output, session) {} # the server

ui = basicPage("our first basic app") # the user interface

shinyApp(ui = ui, server = server) # perform app launch



## Using Input Widgets

server <- function(input,output, session) {
}

ui <-   basicPage(
  h1("Using textInput and checkboxInput"),
  textInput("mystring", "Write here"),
  checkboxInput("mycheckbox", "Factor Y")
)

shinyApp(ui = ui, server = server)



## Making the app reactive

server <- function(input, output, session) {
  observe({
    addtext <- paste("your initial input:", input$mystring)
    updateTextInput(session, "mystring2", value=addtext)
  })
}

ui <-   basicPage(
  h1("Using Observe"),
  textInput("mystring", "Write here"),
  textInput("mystring2", "Full App Output")
)

shinyApp(ui = ui, server = server)



## using reactive and render in one app

server <- function(input, output, session) {
  
  data <- reactive({
    rnorm(50) * input$myslider
  })
  
  output$plot <- renderPlot({
    plot(data(), col = "red", pch = 21, bty = "n")
  })
}

ui <- basicPage(
  h1("Using Reactive"),
  sliderInput(inputId = "myslider",
              label = "Slider1",
              value = 1, min = 1, max = 20),
  plotOutput("plot")
)

shinyApp(ui = ui, server = server)



## layouting - basic sidebar layout

server <- function(input, output, session) {}

ui <- fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      "my sidebar"
    ),
    
    mainPanel(
      "my mainpanel"
    )
  )
)

shinyApp(ui = ui, server = server)



## layouting - tabsets

server <- function(input, output, session) {}

ui <- fluidPage(
  
  titlePanel("using Tabsets"), # our title
  
  sidebarLayout(
    
    sidebarPanel(
      sliderInput(inputId = "s1",
                  label = "My Slider",
                  value = 1, min = 1, max = 20)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Tab1", "First Tab"),
        tabPanel("Tab2", "Second Tab"),
        tabPanel("Tab3", "Third Tab")
      )
    )
  )
)

shinyApp(ui = ui, server = server)

####

names(tags)

####

## Tags

server <- function(input, output, session) {}

ui <- fluidPage(
  
  titlePanel(strong("This is the STRONG tag on the Title")), # using strong as a direct tag
  
  sidebarLayout(
    
    sidebarPanel(
      withTags(
        div(
          b("bold text: here you see a line break, a horizontal line and some code"),
          br(),
          hr(),
          code("plot(lynx)")
        ))),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Weblinks with direct tag a", a(href="http://www.rstudio.com", "r-tutorials")),
        tabPanel(tags$b("Using b for bold text"), tags$b("a bold text")),
        tabPanel("Citations with the blockquote tag", tags$blockquote("R is Great", cite = "R Programmer")),
        tabPanel("First level example", tags$h6("First level"))
      )
    )
  ))

shinyApp(ui = ui, server = server)





## changing the themes

server <- function(input, output, session) {}

library(shinythemes) # adding the shinythemese package

ui <- fluidPage(theme = shinytheme("darkly"), # displaying the different themes, replace this line when publishing with theme = shinytheme("darkly")
                
                titlePanel(strong("This is the STRONG tag on the Title")), # using strong as a direct tag
                
                sidebarLayout(
                  
                  sidebarPanel(
                    withTags(
                      div(
                        b("bold text: here you see a line break, a horizontal line and some code"),
                        br(),
                        hr(),
                        code("plot(lynx)")
                      ))),
                  
                  mainPanel(
                    tabsetPanel(
                      tabPanel("Weblinks with direct tag a", a(href="www.r-tutorials.com", "r-tutorials")),
                      tabPanel(tags$b("Using b for bold text"), tags$b("a bold text")),
                      tabPanel("Citations with the blockquote tag", tags$blockquote("R is Great", cite = "R Programmer"))
                    )
                  )
                ))

shinyApp(ui = ui, server = server)




#Section 3 Code -----------------------------------------------------
## Simple data table

library(shiny)
library(ggplot2)
library(DT)

server <- function(input, output, session) {
  
  output$tableDT <- DT::renderDataTable(diamonds[1:1000,],
                                        options = list(paging=F),
                                        rownames=F,
                                        filter = "top")
  
}

ui <- fluidPage(
  DT::dataTableOutput("tableDT")
)

shinyApp(ui = ui, server = server)





## Datatable styling

library(shiny)
library(ggplot2)
library(DT)

server <- function(input, output, session) {
  
  
  output$tableDT <- DT::renderDataTable(datatable(diamonds[1:1000,],
                                                  options = list(paging=F),
                                                  rownames=F,
                                                  filter = "top") %>%
                                          formatCurrency("price", "$") %>%
                                          formatStyle("price", color = "green") %>%
                                          formatStyle("cut",
                                                      transform = "rotateX(20deg) rotateY(5deg) rotateZ(5deg)",
                                                      backgroundColor = styleEqual(
                                                        unique(diamonds$cut), c("salmon", "lightblue",
                                                                                "grey", "lightgreen", "lightpink"))))
  
  
}

ui <- fluidPage(
  DT::dataTableOutput("tableDT")
)

shinyApp(ui = ui, server = server)





## Advanced App - brush

server <- function(input,output, session) {
  
  
  library(ggplot2) # for the diamonds dataset, and ggplot feature
  library(DT) # for the dataTableOutput
  library(shiny) # should always be activated
  
  
  output$plot <- renderPlot({
    ggplot(diamonds, aes(price, carat)) + geom_point()
  })
  
  diam <- reactive({
    
    user_brush <- input$user_brush
    sel <- brushedPoints(diamonds, user_brush)
    return(sel)
    
  })
  
  output$table <- DT::renderDataTable(DT::datatable(diam()))
}

ui <-   fluidPage(
  h1("Using the brush feature to select specific observations"),
  plotOutput("plot", brush = "user_brush"),
  dataTableOutput("table")
)

shinyApp(ui = ui, server = server)

## Advanced App - click

server <- function(input,output, session) {
  
  library(ggplot2) # for the diamonds dataset, and ggplot feature
  library(DT) # for the dataTableOutput
  
  output$plot <- renderPlot({
    ggplot(diamonds, aes(price, carat)) + geom_point()
  })
  
  diam <- reactive({
    
    user_click <- input$user_click
    sel <- nearPoints(diamonds, user_click, threshold = 10, maxpoints = 5)
    # maxpoints gives the maximum number of observations in the table
    # threshold gives the maximum distance in the dataset
    return(sel)
    
  })
  
  output$table <- DT::renderDataTable(DT::datatable(diam()))
}

ui <-   fluidPage(
  h1("Using the click feature to select specific observations"),
  plotOutput("plot", click = "user_click"),
  dataTableOutput("table")
)

shinyApp(ui = ui, server = server)



## Advanced Plot with csv export

server <- function(input,output, session) {
  
  library(ggplot2) # for the diamonds dataset, and ggplot feature
  library(DT) # for the dataTableOutput
  
  output$plot <- renderPlot({
    
    ggplot(diamonds, aes(price, carat)) + geom_point()
    
  })
  
  diam <- reactive({
    
    user_brush <- input$user_brush
    sel <- brushedPoints(diamonds, user_brush)
    return(sel)
    
  })
  
  output$table <- DT::renderDataTable(DT::datatable(diam()))
  
  output$mydownload <- downloadHandler(
    filename = "plotextract.csv",
    content = function(file) {
      write.csv(diam(), file)})
}

ui <- fluidPage(
  h3("Exporting Data as .csv"),
  plotOutput("plot", brush = "user_brush"),
  dataTableOutput("table"),
  downloadButton(outputId = "mydownload", label = "Download Table")
)

shinyApp(ui = ui, server = server)



## Media Integration

library(shiny)

server = function(input,output) {
}

ui = navbarPage("Integration of different media types",
                
                tabPanel("Image sourced locally",
                         tags$img(src = "logo.png", width = "100px", height = "100px")),
                
                tabPanel("Video sourced locally",
                         tags$video(src = "comist.mp4", type = "video/mp4", controls = T,
                                    width = "900px", height = "800px")),
                
                tabPanel("Pdf sourced online, Iframe",
                         tags$iframe(style="height:600px; width:100%; scrolling=yes",
                                     src="https://cran.r-project.org/web/packages/shiny/shiny.pdf")),
                
                tabPanel("Text as .txt",
                         includeText("mytxt.txt"))
)

shinyApp(ui = ui, server = server)



install.packages("rsconnect")
library(rsconnect)
rsconnect::setAccountInfo(name='mehlamsaifudeen',
                          token='E1F25034337F183ECAB224C276B25CDD',
                          secret='vZ1yw6DsZQa1hOMw0PAokjewRZmJcWy10CGeYWRi')
library(rsconnect)
rsconnect::deployApp('path/to/your/app')




#Project demo from Udemy -------------------------------------
### Project Shiny
library(shiny)
library(DT)
library(ggplot2)
library(shinythemes)

mydata = read.csv('course_proj_data.csv', header = T, sep = ";")

attach(mydata)

server = function(input, output, session){
  
  # table for the Data table tab
  
  output$tableDT <- DT::renderDataTable(DT::datatable(mydata) %>%
                                          formatCurrency("MarketCap.in.M", "$", digits = 0) %>%
                                          formatStyle("Symbol", color = "grey") %>%
                                          formatStyle(c("G3", "G2", "G1"),
                                                      backgroundColor = "lightblue"))
  
  
  weighted.mydata = reactive(
    cbind(mydata,
          points = input$w1 * `G1` + input$w2 * `G2` + input$w3 * `G3`)
  )
  
  
  output$scat = renderPlot({
    ggplot(weighted.mydata(), aes(points, MarketCap.in.M)) +
      geom_point() + geom_smooth(method = "lm") +
      xlab("Your Calculated Score") + ylab("Market Capitalization in Million USD")
  })
  
  
  mydata.new = reactive({
    
    user_brush <- input$user_brush
    mysel <- brushedPoints(weighted.mydata(), user_brush)
    return(mysel)
    
  })
  
  
  output$table = DT::renderDataTable(DT::datatable(mydata.new()))
  
  output$mydownload = downloadHandler(
    filename = "selected_miners.csv",
    content = function(file) {
      write.csv(mydata.new(), file)})
  
  
}

ui = navbarPage(theme = shinytheme("sandstone"), title = h3("The Mining Stock Scale"),
                tabPanel(
                  ("Adjust your Mining Stocks"),
                  wellPanel(
                    sliderInput(inputId = "w1",
                                label = "Weight on Grade 1",
                                value = 7, min = 0, max = 20),
                    sliderInput(inputId = "w2",
                                label = "Weight on Grade 2",
                                value = 2, min = 0, max = 20),
                    sliderInput(inputId = "w3",
                                label = "Weight on Grade 3",
                                value = 0.6, min = 0, max = 6, step = 0.2)
                  ),
                  plotOutput("scat", brush = "user_brush"),
                  DT::dataTableOutput("table"),
                  downloadButton(outputId = "mydownload", label = "Download Table")
                ),
                
                tabPanel("Documentation",
                         h4("Video documentation - Embedded from Youtube"),
                         tags$iframe(style="height:700px; width:100%",
                                     src="https://www.youtube.com/embed/vySGuusQI3Y")
                ),
                
                tabPanel("Data Table with the underlying Data",
                         DT::dataTableOutput("tableDT"))
                
)

shinyApp(ui = ui, server = server)




#Actions button code ----------------------------------------
ui <- fluidPage(
  actionButton(inputId = "clicks", 
               label = "Click Me")
)
server <- function(input, output){
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })
}

shinyApp(ui = ui, server = server)