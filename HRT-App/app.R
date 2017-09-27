library(shiny)
library(leaflet)

clinics <- read.csv("C:/Users/Cellar Door/Documents/Git/hrt-project/clinics.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("HRT Project"),
  sidebarPanel(),
  mainPanel(
    leafletOutput("mymap")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    leaflet(data=clinics) %>%
      addTiles() %>%
      addCircleMarkers(~long,~lat, popup=~name)
  })
  
}

# Run the application 
shinyApp(ui, server)