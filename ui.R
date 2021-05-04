ui <- fluidPage(
    theme = "flatlyST_bootstrap_CTedit.css",
    div(style = "padding: 1px 0px; width: '100%'",
        titlePanel(title = "",
                   windowTitle = "Netflix recommendation Engine")),
    navbarPage(
        # App title
        title = "Netflix Recommendation System",
        #id = "system",
        
        # Dataset ------------------------------------
        tabPanel("Dataset", icon = icon("table"),
                 fluidRow(column(12,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 775px;",
                                           fluidRow(style = "margin-top: 25px;",
                                                    column(12, 
                                                           p(tags$b('Netflix Dataset', style = "font-size: 150%; font-family:Helvetica; color:#4c4c4c; text-align:left;")))),
                                           
                                           DTOutput("tbl"))))),
        
        # Visualization ------------------------------
        tabPanel("Visualization", icon = icon("chart-bar"),
                 fluidRow(column(6,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 500px;",
                                           h5("Histogram of Two Types"),
                                           hr(),
                                           plotlyOutput("type_ggplot"))),
                          column(6,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 500px;",
                                           h5("Trend of Movies and TV Shows"),
                                           hr(),
                                           plotlyOutput("year_ggplot")))),
                 fluidRow(column(6,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 500px;",
                                           h5("Top 20 Countries Producing Most Contents"), 
                                           hr(),
                                           plotlyOutput("country_ggplot"))),
                          column(6,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 500px;",
                                           h5("Distribution of Ratings in Movie and TV Show"),
                                           hr(),
                                           plotlyOutput("rating_ggplot"))))),
        
        #Recommendation Engine -----------------------
        tabPanel("Recommendation Engine", icon = icon("robot"),
                 fluidRow(column(4,
                                 fluidRow(column(12,
                                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 680px;",
                                                           fluidRow(style = 'margin-top: 18px',
                                                                    column(4, style = 'margin-top: 7px', align = 'right', p("Select a type:")),
                                                                    column(8, align = "left",
                                                                           selectInput(inputId="type", label = NULL,
                                                                                       choices=c("Movie", "TV Show"),
                                                                                       selected="TV Show"))),
                                                           fluidRow(style = 'margin-top: 18px',
                                                                    column(4, style = 'margin-top: 7px', align = 'right', p("Title:")),
                                                                    column(8, align = "left",
                                                                           uiOutput("titleSelection"))),
                                                           fluidRow(column(12, submitButton("Submit"))))))),
                          column(8,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 680px;",
                                           fluidRow(column(12,
                                                           withSpinner(DTOutput("results"), type = 5))))))),
        
        # About --------------------------------------
        tabPanel("About", icon = icon("info-circle"),
                 fluidRow(column(12,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50; height: 480px;",
                                           wordcloud2Output("wordcloud")))),
                 fluidRow(column(12,
                                 wellPanel(style = "background-color: #fff; border-color: #2c3e50;",
                                           hr("Motivation"),
                                           p("Recommendation systems are wildely used in social media and commercial industries."),
                                           p("In this project, explore the Netflix dataset and visualize the datasets, build a system to recommend movies/TV shows."),
                                           hr("Content Based Recommendation System"),
                                           p("Recommendation system is a system using \"content based recommended engine\" to predict and filter the future preferences of users based on using five features of cast, director, country, rating, and genres in the system."),
                                           hr("Source"),
                                           br(),
                                           "The dataset is from Kaggle:",
                                           a(href="https://www.kaggle.com/shivamb/netflix-shows", "https://www.kaggle.com/shivamb/netflix-shows")))))
    )
)

