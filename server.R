library(shiny)

# Dataset to obtain data
data(mtcars)

shinyServer(
    function(input, output) {
        # Linear regression model to make estimations
        modFit <- lm(100/mpg~factor(am)*wt,mtcars)
        # Input values are included in a data frame to be used in further calculations. Defined as reactive.
        vals <- reactive({data.frame(wt=input$wt, am=input$am)})
        # Information about the input weight
        output$wt <- renderText({paste('Your car weights',as.numeric(input$wt)*1000, 'lb')})
        # Information about the input transmission type
        output$am <- renderText({paste('The transmission type of your car is ',
            if (input$am==0) "Automatic"
            else "Manual")
        })
        # Output of the prediction
        output$output <- renderText({predict(modFit,vals())})
        # Plot of the consumption vs weight. A red point indicates the input data in the graph
        weight <- seq(1,6,5)
        consumption <- reactive({predict(modFit,data.frame(wt=weight,am=input$am))})
        output$plot <- renderPlot({plot(weight,
                                        consumption(),
                                        main='Fuel consumption vs weight',
                                        type='l',
                                        xlab = 'weight (lb/1000)',
                                        ylab='consumption (US gallon/100 miles)',
                                        ylim = c(0,12))
                                  points(input$wt,predict(modFit,vals()),col='red',lwd=2)})
        
    }
)