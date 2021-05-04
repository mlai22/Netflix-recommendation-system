recommender <- function(type, title){
  if(type == 'Movie'){
    data <- dat1 %>%
      filter(type == 'Movie') %>%
      select(title, director, cast, country, rating, listed_in)
    binary_data <- binary_movie
  } else {
    data <- dat1 %>%
      filter(type == 'TV Show') %>%
      select(title, director, cast, country, rating, listed_in)
    binary_data <- binary_tv
  }
  
  if(title %in% data$title){
    idx <- which(data$title == title)
    target_list <- binary_data[idx,]
    target_list <- as.matrix(target_list)
    
    cosine <- apply(binary_data, 1, function(x){
      list <- as.matrix(x)
      product <- target_list %*% list
      
      norm_target <- norm(target_list, type = 'f')
      norm_movie <- norm(list, type = 'f')
      product /(norm_target * norm_movie)
    })
    
    data['cosine'] <- round(cosine, 3)
    results <- data[order(data$cosine, decreasing = T),]
    results <- results[which(results$title != title),]
    top_results <- head(results, 10)
  } else{
    return(as.data.frame("The title does not exist in the dataset."))
  }
  return(top_results)
}

