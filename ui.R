library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(DT)


weights1 <- readRDS("./data/weights1.rds")

fluidPage(
  titlePanel(title = h4("Comparing price contribution percentage of prices of Ontario, Quebec and Alberta to the overall Canadian Consumer Price Index (CPI)", align = "center")),
  sidebarPanel(
    uiOutput("item"),
    selectInput('reg', 'Select a Region', choices = unique(weights1$Region), multiple = FALSE, selected="Ontario"),
    selectInput('reg1', 'Select a Region to find the difference in the Calculator Tab:', choices = unique(weights1$Region), multiple = FALSE),
    selectInput('cat', 'Select a Category', choices = unique(weights1$Ranking), selected = '0', multiple = FALSE)
  ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Description", p(h4("About this shiny application:")),
               HTML(#"<u><b>Equation for calculation: </b></u>
                 "<br>This application allows users to visualize the percentage contribution
              of the items of the Canadian basket of goods and services to the 
              overall Consumer Price Index for the provinces of
              Ontario, Alberta and Quebec.
              <br>
             <br>
          Users can select between 3 Canadian provinces (Ontario, Alberta, Quebec),
         2 categories: <br> - 0 category which includes 8 items of the basket of goods and services
         <br> 
          <br>  
          - 1 category which includes 19 items of the basket of goods and services 
          <br>  
          <br> 
          The category dropdown menu updates automatically the items dropdown menu.
         <br> <br>
          The output can be seen in the Plot and Table tabs.
        <br> <br>
          The Calculator tab shows the item difference between 2 provinces. 
         ")),
      tabPanel("Plot", plotlyOutput("stackbar", height="400")),
      tabPanel("Table", DTOutput("weights1", height = "500")),
      tabPanel("Calculator", p(h5(tags$b("Item difference between the 2 selected provinces:"))), textOutput("sample"))
    ))
)
