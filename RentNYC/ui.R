# UI
# RentNYC

shinyUI(dashboardPage(
  dashboardHeader(title = "NYC Rent Explored"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Trend", tabName = "trend", icon = icon("calendar"))
    ),
    selectizeInput("boro", "Select Borough to Display", boroDex),
    dateRangeInput("dates", label = "Date range", start = min(med.pr), end = max(med.pr)),
    checkboxGroupInput("nhDex", label = "Checkbox group", 
                       choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                       selected = 1)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "trend",
              "to be replaced with trend by room count and per room")
    )
  )
))
