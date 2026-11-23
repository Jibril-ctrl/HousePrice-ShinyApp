# House Price Explorer

**Interactive Data Exploration | R Shiny · Plotly · Statistical Visualization**

An interactive R Shiny application for investigating how housing characteristics relate to residential sale prices. Built around 1,460 home sales in Ames, Iowa, the application transforms historical housing data into interactive visualizations, descriptive statistics, and interpretable comparisons.

[![Live App](https://img.shields.io/badge/Live%20App-Launch-0E7490?style=flat-square)](https://jibrilanifowoshe.shinyapps.io/Jibril_Anifowoshe_ShinyApp/)
[![Author: Jibril Anifowoshe](https://img.shields.io/badge/Author-Jibril%20Anifowoshe-256D85?style=flat-square)](https://www.linkedin.com/in/jibril-anifowoshe)
[![About](https://img.shields.io/badge/About-Profile-B68A45?style=flat-square)](https://jibrilctrl.com/about/)
[![Project Page](https://img.shields.io/badge/Project%20Page-JibrilCtrl-334155?style=flat-square)](https://jibrilctrl.com/data-insight-app/)

---

## Overview

What shapes the price a home sells for?

House Price Explorer makes it possible to investigate that question across key housing attributes, including living area, construction quality, neighborhood, property age, and other recorded features.

Rather than presenting a single static chart, the application lets users select visualizations, change variables, examine distributions, and review the number of observations behind each result.

The objective is exploratory analysis: making the relationships within a real dataset easier to understand without overstating what those relationships establish.

### Dataset at a glance

| Metric | Value |
|---|---|
| Dataset | Ames Housing |
| Recorded sales | 1,460 |
| Original variables | 81 |
| Sale years | 2006–2010 |
| Median sale price | $163,000 |
| Visualization options | 9 |
| Primary technologies | R, Shiny, Plotly |

**Data source:** [Kaggle — House Prices: Advanced Regression Techniques](https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques/data)

## Features

### Interactive visualization

Nine visualization options support different types of exploratory analysis.

| Visualization | Analytical purpose |
|---|---|
| Histogram | Examine numerical distributions and frequency |
| Density plot | Inspect a smoothed distribution |
| Frequency polygon | Compare frequency patterns across intervals |
| Bar plot | Compare categorical counts |
| Scatter plot | Explore relationships between numerical variables |
| Box plot | Compare numerical distributions across groups |
| Line chart | Examine annual median trends |
| Area chart | Visualize annual median patterns |
| Correlation heatmap | Examine Pearson correlations among seven selected housing measures |

### Configurable analysis

Users can:

- Select a chart type appropriate to the analytical question.
- Choose supported horizontal and vertical variables.
- Adjust intervals for histograms and frequency polygons.
- Generate interactive Plotly charts.
- Inspect observations using chart interactions.
- Review the calculation and observation count associated with each visualization.

### Data summary

The dedicated **Data summary** tab provides field-level statistics, including:

- Recorded and missing values.
- Number of distinct values.
- Minimum, maximum, mean, and median for numerical fields.
- First and third quartiles.
- Observed category frequencies.

These summaries provide context for interpreting visual results.

## Data integrity and analytical methodology

Reliable visualization depends on understanding the records behind each calculation.

The application performs initial checks for required columns, unique column names, unique sale identifiers, and finite sale-price values.

Charts use observations with recorded values for the selected fields. The correlation heatmap applies a common complete-case sample across seven numerical measures.

Observation counts are displayed alongside chart results so users can distinguish the full dataset from the subset used in a particular analysis.

**Interpretation matters.** Correlation does not establish causation. Annual medians can also change because the mix of properties sold changes between years. This project is an exploratory analytics application, not a predictive valuation engine.

## Technology stack

| Component | Technology |
|---|---|
| Application language | R |
| Interactive application framework | Shiny |
| Data visualization | Plotly |
| Statistical processing | Base R |
| Dataset | Kaggle housing CSV |
| Application hosting | shinyapps.io |
| Source management | Git and GitHub |

The current application source requires the `shiny` and `plotly` R packages.

## Repository structure

```text
HousePrice-ShinyApp/
│
├── .gitignore
├── README.md
│
└── HousePrice_ShinyApp_Files/
    ├── JA_ShinyAppProject_Final_Pub.R
    ├── train.csv
    ├── JA_ShinyAPP_Dev_Report.pdf
    ├── README.md
    └── LICENSE
```

The R script contains the application interface, server logic, statistical processing, and visualization functions. The CSV file supplies the source dataset.

## Run locally

### Prerequisites

- R installed on your system.
- Internet access for initial package installation.
- RStudio is optional.

### Installation

Clone the repository:

```bash
git clone https://github.com/Jibril-ctrl/HousePrice-ShinyApp.git
cd HousePrice-ShinyApp/HousePrice_ShinyApp_Files
```

Open R and install the required packages:

```r
install.packages(c("shiny", "plotly"))
```

Launch the application:

```r
shiny::runApp(
  source("JA_ShinyAppProject_Final_Pub.R")$value
)
```

Run the application from the directory containing both the R script and `train.csv`, because the application loads the dataset using a relative path.

The published shinyapps.io deployment uses the application entry point `app.R` alongside the dataset.

## Project development

The project originated on **April 8, 2024**, as part of INFSYS 6830 at the University of Missouri–St. Louis under Dr. Vivek K. Singh.

The original work focused on applying R Shiny to interactive analysis of Kaggle housing data.

A November 2026 redesign introduced a revised interface, field-aware chart selection, clearer observation coverage, and a more deliberate presentation of statistical results.

The original development report documents the academic implementation and historical methodology. This README describes the current published repository source.

**Project resources**

- [Launch House Price Explorer](https://jibrilanifowoshe.shinyapps.io/Jibril_Anifowoshe_ShinyApp/)
- [Application source](https://github.com/Jibril-ctrl/HousePrice-ShinyApp/blob/main/HousePrice_ShinyApp_Files/JA_ShinyAppProject_Final_Pub.R)
- [Original development report](https://github.com/Jibril-ctrl/HousePrice-ShinyApp/blob/main/HousePrice_ShinyApp_Files/JA_ShinyAPP_Dev_Report.pdf)
- [Dataset documentation](https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques/data)
- [Project portfolio page](https://jibrilctrl.com/data-insight-app/)

## Author

**[Jibril Anifowoshe, M.S., CISM](https://www.linkedin.com/in/jibril-anifowoshe)**

Senior Security Architect · Engineer · AI Security Strategist

My engineering work spans cybersecurity, cloud architecture, AI security, and applied data analytics. House Price Explorer is an independent project demonstrating interactive statistical analysis, data integrity considerations, and application development using R Shiny.

[About](https://jibrilctrl.com/about/) · [Portfolio](https://jibrilctrl.com/) · [LinkedIn](https://www.linkedin.com/in/jibril-anifowoshe)

## License and attribution

The original project code is distributed under the [MIT License](HousePrice_ShinyApp_Files/LICENSE).

The housing dataset originates from Kaggle's *House Prices: Advanced Regression Techniques* competition and remains subject to its applicable source terms.

© 2024–2026 Jibril Anifowoshe. Original project and documentation attribution retained.
