# UI
# RentNYC

shinyUI(fluidPage(
  titlePanel("TEST TITLE"),
  sidebarLayout(
    sidebarPanel(
      
      selectizeInput(inputId = "boroPick",
                     label = "Select a Borough",
                     choices = unique(med.pr$Borough)),
      
      checkboxGroupInput(inputId = "nhPick",
                         label = "Neighborhoods",
                         choices = unique(med.pr$Neighborhood))
      
    ),
    mainPanel(
      
      textOutput("outBoroNH")
      
      )
    )
))

























# shinyUI(dashboardPage(
#   dashboardHeader(title = "NYC Rent Explored"),
#   dashboardSidebar(
#     sidebarMenu(
#       menuItem("trend", tabName = "Trend", icon = icon("calendar")),
#       menuItem("dt", tabName = "Data", icon = icon("star")),
#       selectizeInput("boroPick", "Select Borough to Display", choices = boroList),
#       dateRangeInput("datePick", label = "Date Range", 
#                      start = min(med.pr[, "Month"]), end = max(med.pr[, "Month"]), 
#                      min = min(med.pr[, "Month"]), max = max(med.pr[, "Month"])
#                      ),
#       checkboxGroupInput(inputId = "nhPick", label = "Neighborhoods")
#     )
#   ),
#   dashboardBody(tabItems(
#     tabItem(tabName = "Trend",
#             fluidRow(
#               box(verbatimTextOutput("boro")),
#               
#               
#               
#               box(
#                 
#                 
#                 checkboxGroupInput("inCheckboxGroup", "Input checkbox",
#                                      c("Item A", "Item B", "Item C")),
#                   checkboxGroupInput("inCheckboxGroup2", "Input checkbox 2",
#                                      c("Item A", "Item B", "Item C")))
#               
#               
#               
#               )
#             ),
#     tabItem(tabName = "dt",
#             fluidRow(box(
#               DT::dataTableOutput("table"), width = 12
#             )))
#   ))
# ))
