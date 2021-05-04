# Netflix-recommendation-system
#### Overview
[Shiny app](https://mlai22.shinyapps.io/netflixRS/)

The app is designed for Netflix recommendation system.  
The motivation of this project is to explore the Netflix dataset and build a recommendation system based on the contents of users' preferences.  
Using content-based recommendation system to calculate cosine similarity scores, and return the top 10 movies/TV shows which users are likely to be interested in.  

#### Limitation
The shiny app is running out of memory due to the large binary datasets, 
so the recommendation system in the app was displayed by a toy dataset 
for showing the results.  
If you would like to have precision predictions, please download this repository 
and run the shiny app locally.

#### Requirements
The following R packages are required:
- `shiny`
- `tidyverse`
- `DT`
- `plotly`
- `ggplot2`
- `wordcloud2`
- `shinycssloaders`

#### License
Distributed under the GNU General Public License v3.0.
See [`LICENSE`](https://github.com/mlai22/Netflix-recommendation-system/blob/main/LICENSE) for more information.

#### Contact
Mei-Yu Lai - mlai22@jhu.edu
- MSE student in Biomedical Engineering at Johns Hopkins University

#### Reference
Kaggle: https://www.kaggle.com/shivamb/netflix-shows