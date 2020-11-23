library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #load data
    data("mtcars")
    
    #clean dataset to be used for the app
    mtcars2 <- within(mtcars, {
        am <- factor(am, labels = c("automatic", "manual")) #transmission
        cyl  <- ordered(cyl) #number of cylinders
        wt <- 1000 * wt #weight in lbs
    })
    
    #define linear model
    model <- lm(mpg ~ cyl + am + disp + wt, data = mtcars2)
    
    #prediction based on UI input
    modelPred <- reactive({
        input_df <- data.frame(cyl = input$cyl,
                               am = input$am,
                               disp = input$disp,
                               wt = input$wt)
        predict(model, newdata = input_df)
    })

    #plot the data
    output$plot <- renderPlot({
        
        ggplot(data=mtcars2, aes(x=wt, y=mpg)) + 
            geom_point() +
            geom_smooth(method = "lm") +
            labs(x="Weight (lbs)", y="MPG (US gal)", title = "MPG of Automobile")
    })
    output$pred <- renderText({
        modelPred()
    })
    
})