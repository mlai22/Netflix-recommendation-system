server <- function(input, output, session){
    # Present the Netflix dashboard Table
    typeDF <- reactive({
        req(input$type)
        if(input$type == "Movie"){
            df <- dat1 %>%
                filter(type == 'Movie') %>%
                select(title, director, cast, country, rating, listed_in)
        }else {
            df <- dat1 %>%
                filter(type == 'TV Show') %>%
                select(title, director, cast, country, rating, listed_in)
        }
        df
    })
    
    # year_table -----------------------------------------------------------------
    output$tbl <- renderDT({
        datatable(dat, 
                  options = list(info = F,
                                 paging = T,
                                 searching = T,
                                 stripeClasses = F, 
                                 lengthChange = T,
                                 scrollY = '505px',
                                 scrollCollapse = T),
                  rownames = F)
    })
    
    # type_barplot ---------------------------------------------------------------
    output$type_ggplot <- renderPlotly({
        type <- dat %>%
            group_by(type) %>%
            count()
        colnames(type) <- c("Type", "Count")
        
        plot <- ggplot(type, aes(x = Type, y = Count, fill = Type)) +
            geom_bar(stat = 'identity')
        ggplotly(plot)
    })
    
    # Top 20 countries producing most contents_histogram -------------------------
    output$country_ggplot <- renderPlotly({
        country <- lapply(dat$country, function(x){
            unlist(str_split(x, ', '))
        })
        count_country <- table(unlist(country))
        country_freq <- as.data.frame(count_country)
        colnames(country_freq) <- c('Country', 'Count')
        x <- country_freq[order(country_freq$Count, decreasing = T),]
        
        plot <- ggplot(head(x, 20), aes(x = Country, y = Count)) +
            geom_bar(stat = 'identity') +
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
        ggplotly(plot)
    })
    
    # year_plot ------------------------------------------------------------------
    output$year_ggplot <- renderPlotly({
        year <- table(dat$type, dat$release_year)
        year <- as.data.frame(year)
        colnames(year) <- c('Type', 'Year', 'Count')
        
        plot <- ggplot(year, aes(x = Year, y = Count, group = Type)) +
            geom_line(aes(color=Type)) +
            geom_point(aes(color=Type)) +
            theme(axis.text.x=element_text(angle=90, hjust=1))
        ggplotly(plot)
    })
    
    # rating_plot ----------------------------------------------------------------
    output$rating_ggplot <- renderPlotly({
        rating <- table(dat$type, dat$rating)
        rating <- as.data.frame(rating)
        colnames(rating) <- c("Type", "Rating", "Count")
        
        plot <- ggplot(rating, aes(x = Rating, y = Count, fill = Type)) +
            geom_bar(stat = "identity", position = position_dodge()) +
            theme(axis.text.x=element_text(angle=45, hjust=1))
        ggplotly(plot)
    })
    
    # recommendation results -----------------------------------------------------
    rcmd_results <- reactive({
        req(input$type, input$title)
        recommender(input$type, input$title)
    })
    
    output$results <- renderDT({
        datatable(rcmd_results(),
                  options = list(info = F,
                                 paging = F,
                                 searching = T,
                                 stripeClasses = F, 
                                 lengthChange = F,
                                 scrollY = '505px',
                                 scrollCollapse = T))
    })
    
    # wordcloud ------------------------------------------------------------------
    output$wordcloud <- renderWordcloud2({
        set.seed(123)
        listedin <- lapply(dat$listed_in, function(x){
            unlist(str_split(x, ', '))
        })
        listedin_freq <- table(unlist(listedin))
        listedin_df <- as.data.frame(listedin_freq)
        wordcloud2(listedin_df)
    })
    
    # title depend on type -------------------------------------------------------
    observeEvent(input$submit, {
        updateTextInput(session, "titleSelection", label = NULL,
                        value = input$title)
    })
    
    output$titleSelection <- renderUI({
        init <- reactive({
            ifelse(input$type == "Movie", "Rocky", "Stranger Things")
        })
        textInput("title", label = NULL, value = init())
    })
    
}

