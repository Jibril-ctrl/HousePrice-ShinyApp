# House Price Explorer

[![Author: Jibril Anifowoshe](https://img.shields.io/badge/Author-Jibril%20Anifowoshe-7928CA?style=flat)](https://jibrilctrl.com/) · [Open the live application](https://jibrilanifowoshe.shinyapps.io/Jibril_Anifowoshe_ShinyApp/)

How did sale prices vary with living area, construction quality and neighborhood? House Price Explorer lets readers investigate those relationships across 1,460 residential sales in Ames, Iowa, from 2006 through 2010. The median recorded sale price was **$163,000**. Each chart identifies the fields, calculation and number of sales behind the result.

## Explore the data

Choose a view and its fields, then select **Generate Chart**. For a first comparison, choose **Scatter plot**, set the horizontal field to **Living area (sq ft)** and the vertical field to **Sale price (USD)**. Hover over a point to inspect a sale.

| Question | Views | What the chart shows |
| --- | --- | --- |
| How are values distributed? | Histogram, density plot, frequency polygon | The shape and spread of a numerical field. The interval control applies to the histogram and frequency polygon. |
| How do categories compare? | Bar plot, box plot | Counts by category or the distribution of a numerical field within each group. |
| Which features move together? | Scatter plot, correlation heatmap | Individual observations or Pearson correlations across seven selected housing fields. |
| How did the typical sale change by year? | Line chart, area chart | The annual median of the selected measure, grouped by sale year. |

The **Data summary** tab reports recorded, missing and distinct values for each field. Numerical fields include quartiles, range, mean and median. Categorical fields include counts by observed value.

## Data and interpretation

The application reads the bundled training CSV. At startup it checks required fields, column-name uniqueness, sale ID uniqueness and finite sale prices. Charts use records with values for their selected fields. The heatmap uses the same complete rows across all seven measures.

An association between two features can reflect other differences among homes. Annual medians also depend on which properties sold that year. These historical observations support exploratory analysis. [Kaggle dataset and field documentation](https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques/data)

## Run locally

Clone or download the repository, open R in its top-level directory and run:

```r
install.packages(c("shiny", "plotly"))  # First-time setup
setwd("HousePrice_ShinyApp_Files")
shiny::runApp(source("JA_ShinyAppProject_Final_Pub.R")$value)
```

The repository retains the original R filename for its commit history. The shinyapps.io deployment packages the same application as `app.R` alongside `train.csv`. GitHub stores the source and project documentation. Shinyapps.io serves the published application.

## Project background

Jibril Anifowoshe designed and developed the original application on April 8, 2024, for INFSYS 6830 at the University of Missouri–St. Louis under Dr. Vivek K. Singh. The November 2026 redesign adds field-aware chart controls, visible record coverage and a dark interface.

[Development report](https://github.com/Jibril-ctrl/HousePrice-ShinyApp/blob/main/HousePrice_ShinyApp_Files/JA_ShinyAPP_Dev_Report.pdf) · [Source code](https://github.com/Jibril-ctrl/HousePrice-ShinyApp/blob/main/HousePrice_ShinyApp_Files/JA_ShinyAppProject_Final_Pub.R) · [MIT license for the project code](https://github.com/Jibril-ctrl/HousePrice-ShinyApp/blob/main/HousePrice_ShinyApp_Files/LICENSE)
