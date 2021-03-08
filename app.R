# ----------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------- #
#                                                                                           #
#                             Sliding Window Shiny Server                                   #                                                                        
#                                                                                           #
# ----------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------- #

# ========================================================================================= #
#                                                                                           #
#########                                 ABOUT                                     #########
#                                                                                           #
# ========================================================================================= #

# (c) 2021
# Title: Shiny Server - Sliding Window Analysis for 
# Author: Patrick Neubert (patrick.neubert@cos.uni-heidelberg.de)
# Twitter: @_Nerdbert_
# Description: Shiny Server Project with webscraping functionalities that highlights PTMs within
#   the context of the protein's sequential features (Sliding Window)

# ========================================================================================= #
#    http://shiny.rstudio.com/


# ========================================================================================= #
#                                                                                           #
#########                               VERSION                                     #########
#                                                                                           #
# ========================================================================================= #

# define version
versionNumber <- "0.1"
versionDate   <- "2021-02-17"
# welcome message
message(c('Hello! You started the Sliding Window Shiny Viewer ', versionNumber, ' from ', versionDate, '.\n'))

# ========================================================================================= #
#                                                                                           #
#########                          LOADING LIBRARIES                                #########
#                                                                                           #
# ========================================================================================= #

### Loading libraries
# Note: "parallel", "foreach", "doParallel", "doSNOW" is currently not needed
# packages <- c("ggplot2", "gridExtra", "tidyverse", "gplots", "ggrepel", 
#"stringr", "plotly")

source("R/load_packages.R")

# Define packages needed
packages <- c("shiny", "shinythemes", "ggplot2", "gridExtra", "tidyverse", "gplots", "ggrepel", 
              "stringr", "plotly")

load_packages(packages)

# ========================================================================================= #
#                                                                                           #
#########                         LOADING FUNCTIONS                                 #########
#                                                                                           #
# ========================================================================================= #

# List files in "R/"
fn_R <- list.files(path = "R/", recursive=T, full.names = TRUE)
# # Select functions
# nFunctions <- grep("", fn_R)
# Source all functions
for(fun in fn_R){
    source(fun)
}

# ========================================================================================= #
#                                                                                           #
#########                          SHINY APPLICATION                                #########
#                                                                                           #
# ========================================================================================= #

#### UI Component ####

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Theme
    theme = shinytheme("yeti"),

    # Application title
    titlePanel("PTM and Motif Viewer"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(

        sidebarPanel(
            textInput("uniprotAC", "UniprotAC:", ""),
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30
                        )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("outPlot")
        )
    )
)

#### Server Component ####


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$outPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

#### App Component ####

# Run the application 
shinyApp(ui = ui, server = server)
