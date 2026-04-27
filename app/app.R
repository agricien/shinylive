library(shiny)

ui <- fluidPage(
  titlePanel("Antigravity Shinylive Baseline"),
  mainPanel(
    h3("Hello from WebAssembly!"),
    p("This app was deployed after resolving metadata issues."),
    verbatimTextOutput("info")
  )
)

server <- function(input, output, session) {
  output$info <- renderPrint({
    sessionInfo()
  })
}

shinyApp(ui = ui, server = server)
