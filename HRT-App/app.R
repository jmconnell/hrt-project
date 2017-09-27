library(shiny)
library(leaflet)

clinics <- read.csv("C:/Users/Cellar Door/Documents/Git/hrt-project/clinics.csv")

ui <- fluidPage(
  titlePanel("HRT Project"),
  sidebarPanel(
    
    #adjust this to be dynamic and adjust according to choices in data
    checkboxGroupInput("doctype","Type of Medical Care",
                       c("HRT"="hrt",
                         "Informed Consent Only"="ic")
                       )
      
  ),
  mainPanel(
    leafletOutput("mymap")
  )
)

server <- function(input, output, session) {
  
  if(clinics$street2!="")
    street2 <- paste(clinics$street2,"<br>")
  else
    street2 <- ""
  
  #fix this url issue
  #url <- a(clinics$name, href=clinics$website, target="_blank")

  
  popup1 <- paste(clinics$name,"<br>",clinics$street1,"<br>",street2,clinics$city,", ",clinics$state,", ",clinics$ZIP,"<br>",clinics$phone, sep="")
  
  output$mymap <- renderLeaflet({
    leaflet(data=clinics) %>%
      addTiles() %>%
      addCircleMarkers(~long,~lat,popup=popup1)
  })
  
}

# Run the application 
shinyApp(ui, server)