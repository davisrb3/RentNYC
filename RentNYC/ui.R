# UI
# RentNYC

shinyUI(dashboardPage(
  dashboardHeader(title = "NYC Rent Explored"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("trend", tabName = "Trend", icon = icon("calendar")),
      menuItem("dt", tabName = "Data", icon = icon("star")),
      selectizeInput("boroPick", "Select Borough to Display", boroList),
      dateRangeInput(
        "datePick",
        label = "Date Range",
        start = min(med.pr[, "Month"]),
        end = max(med.pr[, "Month"]),
        min = min(med.pr[, "Month"]),
        max = max(med.pr[, "Month"])
      ),
      checkboxGroupInput(inputId = "nhPick", label = "Neighborhoods", choices = NULL)
    )
  ),
  dashboardBody(tabItems(
    tabItem(tabName = "Trend",
            fluidRow(
              box(htmlOutput("trend")),
              
              
              
              box(
                
                
                checkboxGroupInput("inCheckboxGroup", "Input checkbox",
                                     c("Item A", "Item B", "Item C")),
                  checkboxGroupInput("inCheckboxGroup2", "Input checkbox 2",
                                     c("Item A", "Item B", "Item C")))
              
              
              
              )
            ),
    tabItem(tabName = "DataTable",
            fluidRow(box(
              DT::dataTableOutput("table"), width = 12
            )))
  ))
))
