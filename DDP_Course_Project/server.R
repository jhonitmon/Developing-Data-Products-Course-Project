#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  library(ggplot2)
  library(dplyr)
  library(caret)
  
  data("mpg")
  data <- mpg[,-c(1,2)]
  data$trans <- gsub("auto.+","auto",data$trans)
  data$trans <- gsub("manual.+","manual",data$trans)
  data$trans <- as.factor(data$trans)
  data$year <- as.factor(data$year)
  data$drv <- as.factor(data$drv)
  data$fl <- as.factor(data$fl)
  data$class <- as.factor(data$class)
  data$cyl <- as.factor(data$cyl)
  
  modelCty <- lm(cty ~ ., data = data[,-7])
  modelHwy <- lm(hwy ~ ., data = data[,-6])
  
  pred_Cty <- reactive({
    pred_df <- data.frame("displ" = input$sliderDispl, "year" = as.factor(input$radioYear), "cyl" = as.factor(input$radioCyl),
                        "trans" = as.factor(input$radioTrans), "drv" = as.factor(input$radioDrv),
                        "fl" = as.factor(input$radioFuel),"class" = as.factor(input$radioClass))
    unname(round(predict(modelCty,pred_df),2))
  })
  
  pred_Hwy <- reactive({
    pred_df <- data.frame("displ" = input$sliderDispl, "year" = as.factor(input$radioYear), "cyl" = as.factor(input$radioCyl),
                          "trans" = as.factor(input$radioTrans), "drv" = as.factor(input$radioDrv),
                          "fl" = as.factor(input$radioFuel),"class" = as.factor(input$radioClass))
    unname(round(predict(modelHwy,pred_df),2))
  })
  
  output$predCty <- renderText({pred_Cty()})
  output$predHwy <- renderText({pred_Hwy()})

})
