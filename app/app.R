library(shiny)
library(leaflet)
library(ggplot2)
library(bslib)

ui <- page_sidebar(
  theme = bs_theme(bootswatch = "cyborg"),
  title = "Antigravity Interactive Dashboard",
  sidebar = sidebar(
    title = "Controls",
    sliderInput("points", "Number of points (mtcars):", min = 1, max = 32, value = 20),
    p("Everything here runs in your browser via WebAssembly.")
  ),
  layout_column_wrap(
    width = 1/2,
    card(
      card_header("Geospatial View"),
      leafletOutput("map")
    ),
    card(
      card_header("Statistical Analysis"),
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(lng = -84.09, lat = 9.92, popup = "San José, Costa Rica") %>%
      setView(lng = -84.09, lat = 9.92, zoom = 12)
  })
  
  output$plot <- renderPlot({
    ggplot(mtcars[1:input$points, ], aes(x=wt, y=mpg)) + 
      geom_point(size = 4, color = "#007bff", alpha = 0.7) +
      geom_smooth(method = "lm", se = FALSE, color = "#ffc107") +
      theme_minimal() +
      labs(title = "Car Weight vs Fuel Efficiency", subtitle = "Live calculation in Wasm")
  })
}

shinyApp(ui = ui, server = server)
