#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Predicting Gas Mileage Depending on Certain Conditions"),

    # Sidebar with a slider input for prediction variables
    sidebarLayout(
      
      # sidebar panel with all factors
      sidebarPanel(
        
        # slider with engine displacement
        sliderInput("sliderDispl", label = h3("Engine Displacement"), min = 1.6,
                    max = 7, value = 2.8, step = 0.1),
        
        # drop down menu with fabrication year
        selectInput("radioYear", label = h3("Year of Fabrication"),
                     choices = list("1999" = "1999", "2008" = "2008"),
                     selected = "1999"),
        
        # drop down menu with number of cylinders
        selectInput("radioCyl", label = h3("Number of Cylinders"),
                     choices = list("4" = 4, "5" = 5, "6" = 6, "8" = 8),
                     selected = 4),
        
        # drop down menu with type of transmission
        selectInput("radioTrans", label = h3("Type of Transmission"),
                     choices = list("Automatic" = "auto", "Manual" = "manual"),
                     selected = "auto"),
        
        # drop down menu with type of drive train
        selectInput("radioDrv", label = h3("Type of Drive Train"),
                     choices = list("Front-wheeled" = "f", "4-wheeled" = "4", "Rear-wheeled" = "r"),
                     selected = "f"),
        
        # drop down menu with fuel type
        selectInput("radioFuel", label = h3("Fuel Type"),
                     choices = list("Regular" = "r", "Diesel" = "d", "Premium" = "p", 
                                    "Ethanol E85" = "e", "CNG" = "c"),
                     selected = "r"),
        
        # drop down menu with auto class
        selectInput("radioClass", label = h3("Auto Class"),
                     choices = list("Two-Seater" = "2seater", "Compact" = "compact", "Midsize" = "midsize", 
                                    "Minivan" = "minivan", "Pickup" = "pickup", "Subcompact" = "subcompact",
                                    "SUV" = "suv"),
                     selected = "2seater"),
      ),
        # Show the predictions
        mainPanel(
          h2("Prediction for City Mileage"),
          h3(textOutput("predCty")),
          h2("Prediction for Highway Mileage"),
          h3(textOutput("predHwy"))
        )
    )
))
