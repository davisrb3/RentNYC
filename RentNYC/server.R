# Server
# RentNYC

shinyServer(function(input,output, session){
  
  observe({
    b <- input$boroPick
    
    updateCheckboxGroupInput(session, "nhPick", label = paste(b,"Neighborhoods"),
                             choices = med.pr["Borough" == b, "Neighborhoods"])
    
    
    nhList <- med.pr %>% filter(., Borough %in% input$boropick) %>% 
      arrange(., Neighborhood) %>% 
      select(.,Neighborhood) %>% 
      unique(.)
    nh <- input$nhPick
    updateCheckboxGroupInput(session, inputId = "nhPick", choices = NULL)
    
    
    
    
    
    x <- input$inCheckboxGroup
    
    # Can use character(0) to remove all choices
    if (is.null(x))
      x <- character(0)
    
    # Can also set the label and select items
    updateCheckboxGroupInput(session, "inCheckboxGroup2",
                             label = paste("Checkboxgroup label", length(x)),
                             choices = x,
                             selected = x
    )
    
    
    
    
    
    
    
    
    
    
    
    
    })  
  
  refine <- reactive({
    med.pr %>% filter(., Borough %in% input$boroPick, 
                      Month >= ymd(input$datePick[1]), 
                      Month <= ymd(input$datePick[2]),
                      Neighborhood %in% input$nhPick)
    
    })

  output$table <- DT::renderDataTable({
    datatable(refine)
    })
  
  output$trendplot <- renderPlot(
    refine %>% ggplot(., mapping = aes(x = Month, y = medRent)) +
      geom_point(aes(color = Rooms)) +
      geom_smooth(aes(color = Rooms)) +
      ggtitle("Median Rent Over Time")
    )
  
  output$trenddt <- DT::renderDataTable({ 
    datatable(refine) 
    })
  
})
  
test <- med.pr %>% filter(.,
         Borough %in% c("Queens"), 
         Month >= ymd("2011.01.01"), 
         Month <= ymd("2017.12.31"), 
         Neighborhood %in% c("Astoria", "Forest Hills"))   
head(test)


  
  
  
  