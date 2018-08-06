library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(DT)


weights1 <- readRDS("/home/atai/Documents/Coursera/Developing_data_products/Assign_3/application/data/weights1.rds")


shinyServer(function(input, output) {
  data <- reactive({
    
    plotdata <- weights1 %>%  
      as.data.frame() %>% 
      filter(Region %in% input$reg & Ranking %in% input$cat & Item %in% input$item)
  })
  
  output$item <- renderUI({
    selectInput('item', 'Select an Item', choices = weights1[weights1$Ranking==input$cat, "Item"], multiple = FALSE, selected = "Food")
  })
  
  output$stackbar <- renderPlotly({
    ggplotly(ggplot(data(), aes(x = Region, y = X2015,
                                fill=factor(Item), order= Item))+
               geom_bar(stat = "identity") + 
               xlab("Jurisdiction") +
               ylab("Percentage") +
               theme_minimal()+
               ggtitle("Price weights") +
               guides(fill=guide_legend(title="Item", reverse = T))+
               theme(plot.title=element_text(family="Arial", face="bold", size=18),
                     axis.text.x = element_text(angle = 0, family="Arial", size=13), 
                     axis.text.y = element_text(angle = 0, family="Arial", size=13),
                     axis.title.x = element_text(size=14, face="bold", vjust = -1),
                     axis.title.y = element_text(size=14, face="bold", vjust = 2)
               ), tooltip = c("x", "y", "order")) %>% layout(yaxis = list(range = c(1, 100))) 
  })
  output$weights1<-renderDT({data()
  }) 
  
  diff<- function(x){
    d <- x %>% filter(Region == input$reg & Item == input$item) %>% select(X2015)
    f <- x %>% filter(Region == input$reg1& Item == input$item) %>% select(X2015)
    g <- d-f
    return(as.character(g))
  }
  
  output$sample<-renderText(diff(weights1))
  
})