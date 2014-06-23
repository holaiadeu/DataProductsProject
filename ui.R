library(shiny)

shinyUI(pageWithSidebar(
    # Header title
    headerPanel("Prediction of car fuel consumption based on weight and transmission type"),
    
    
    sidebarPanel(
        #W eight input
        numericInput("wt", 
                     label = h4("Weight (expressed in lb/1000)"), 
                     value = 3,
                     min=1,
                     max=6,
                     step=0.1),
        # Transmission type input
        radioButtons("am",
                     label=h4("Transmission type:"),
                     choices=list("Automatic" = 0,"Manual" = 1),
                     selected=0)
    ),
    mainPanel(
        # Description
        h4('Application Description'),
        p('This application predicts the fuel consumption per 100 miles (expressed as US gallon/100 miles) of a car depending on its weight (expressed in lb/1000) and the transmission type (automatic or manual).'),
        # Results
        h4('Results'),
        textOutput('wt'),
        p(''),
        textOutput('am'),
        p(''),
        p('Based on this inputs and our car dataset, the estimated Us gallon consumption per 100 miles is'),
        # Consumption estimation result
        verbatimTextOutput('output'),
        p("The following graphic plots the fuel consumption per 100 miles versus the weight. The red point indicates your car's weight."),
        # Plot of consumption based on weight
        plotOutput('plot')
    )
))