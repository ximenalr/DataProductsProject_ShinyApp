#Fit linear model of mtcars dataset where user can choose the variable to include
library(shiny)
library(ggplot2)

#load data
data("mtcars")

#clean dataset to be used for the app
mtcars2 <- within(mtcars, {
    am <- factor(am, labels = c("automatic", "manual")) #transmission
    cyl  <- ordered(cyl) #number of cylinders
    wt <- 1000 * wt #weight in lbs
    })

# Define UI for application
shinyUI(fluidPage(

    # Application title
    titlePanel("Find the MPG of an Automobile"),

    # Sidebar with a slider inputs and select inputs
    sidebarLayout(
        sidebarPanel(
            selectInput("cyl", "Number of Cylinders", 
                        choices = sort(unique(mtcars2$cyl))),
            selectInput("am", "Transmission", 
                        choices = unique(mtcars2$am)),
            sliderInput("disp", "Displacement (cu.in)",
                        min = min(mtcars2$disp), max = max(mtcars2$disp),
                        value = floor(median(mtcars2$disp)), step = 5),
            sliderInput("wt", "Weight (lbs)",
                        min = min(mtcars2$wt), max = max(mtcars2$wt),
                        value = floor(median(mtcars2$wt)), step = 10),
            h4("Predicted MPG (US gal)"), 
            textOutput("pred"),
            submitButton("Submit")
        ),

        # Show plot of mpg vs weight 
        mainPanel(
            plotOutput("plot")
        )
    )
))