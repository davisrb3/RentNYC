# Server
# RentNYC

shinyServer(function(input,output){
  output$trend <- renderPlot(
    med.pr %>% 
      filter(.,
             Borough == input$Boro,
             between(Month,input$dates[1], input$dates[2]),
             Neighborhood %in% input$nh) %>% 
      ggplot(., mapping = aes(x = Month, y = MedRent)) + 
      geom_point(aes(color = Neighborhood)) + 
      geom_smooth(aes(color = Neighborhood))
    )
  }
  )
