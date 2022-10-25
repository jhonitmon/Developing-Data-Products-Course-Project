#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# define server logic required to dpredict gas mileage
shinyServer(function(input, output) {
  
  # loading libraries
  library(ggplot2)
  library(dplyr)
  library(caret)
  
  # loading mpg data set
  data("mpg")
  
  # removing manufacturer and model columns
  data <- mpg[,-c(1,2)]
  
  # simplification of the trans variable
  data$trans <- gsub("auto.+","auto",data$trans)
  data$trans <- gsub("manual.+","manual",data$trans)
  
  # factorization of all non-number variables
  data$trans <- as.factor(data$trans)
  data$year <- as.factor(data$year)
  data$drv <- as.factor(data$drv)
  data$fl <- as.factor(data$fl)
  data$class <- as.factor(data$class)
  data$cyl <- as.factor(data$cyl)
  
  # application of linear models to data
  modelCty <- lm(cty ~ ., data = data[,-7])
  modelHwy <- lm(hwy ~ ., data = data[,-6])
  
  # prediction based on the drop down menus and slider from the ui
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
  
  # definition of output variables
  output$predCty <- renderText({pred_Cty()})
  output$predHwy <- renderText({pred_Hwy()})

})
