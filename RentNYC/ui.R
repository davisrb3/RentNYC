# UI
# RentNYC

shinyUI(dashboardPage(
  dashboardHeader(title = "NYC Rent Explored"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Trend", tabName = "trend", icon = icon("calendar"))
    ),
    selectizeInput("selected", "Select Borough to Display", boro)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "trend",
              "to be replaced with trend by room count and per room")
    )
  )
))