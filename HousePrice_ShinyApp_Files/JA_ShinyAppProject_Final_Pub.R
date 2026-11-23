#################################################################################################
# HOUSE PRICE EXPLORER | R SHINY APPLICATION
# Designed and developed by Jibril Anifowoshe.
# Please credit Jibril Anifowoshe when reusing or adapting this work.
#
# University of Missouri–St. Louis | INFSYS 6830
# Course instructor: Dr. Vivek K. Singh
# Original project date: April 8, 2024
#
# Data source: Kaggle, House Prices: Advanced Regression Techniques
# Data file: train.csv
# https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques/data
#################################################################################################

library(shiny)
library(plotly)

app_css <- r"(:root {--ink:#F3F4F6;--teal:#38BDF8;--paper:#0B1017;--line:#374151}
body{background:var(--paper);color:var(--ink);font:16px/1.55 "Inter",-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif}
.shell{max-width:1240px;margin:auto;padding:0 clamp(0px,2vw,32px)}
.mast,footer{display:flex;align-items:center;justify-content:space-between;padding:20px 0;gap:15px}
.mast strong{font:600 18px Georgia,serif}.mast span,.eyebrow,.overline,.metric span{font:700 11px/1.5 "IBM Plex Mono",monospace;letter-spacing:.13em;text-transform:uppercase}
.hero{border-radius:14px 14px 0 0;background:linear-gradient(108deg,#1F2937 22%,#182D40 80%,#15394D);color:#F3F4F6;display:flex;align-items:center;justify-content:space-between;gap:4%;padding:32px clamp(20px,4vw,55px)}
.hero h1{font:normal clamp(36px,5.5vw,72px)/1.04 Georgia,serif;letter-spacing:-.05em;margin:12px 0}.hero p:last-child{max-width:590px;color:#CBD5E1;margin:0}
.eyebrow{color:#38BDF8}.signature{flex:0 1 25%;height:94px;display:flex;align-items:end;gap:3px;border-bottom:1px solid #476178}.signature i{background:linear-gradient(#38BDF8,#14739D);flex:1;min-height:2px}
.metrics{display:grid;grid-template-columns:repeat(3,1fr);background:#1F2937;border:1px solid var(--line);border-radius:0 0 14px 14px;overflow:hidden;margin-bottom:22px}
.metric{padding:16px clamp(12px,3vw,40px)}.metric+.metric{border-left:1px solid var(--line)}.metric span{display:block;color:#CBD5E1}.metric strong{display:block;font:normal clamp(21px,2.5vw,34px) Georgia,serif}
.nav-tabs{border:0;margin:0 0 15px}.nav-tabs>li>a,.nav-tabs>li.active>a,.nav-tabs>li.active>a:focus{border:0;border-radius:6px;background:transparent;color:var(--ink);font-weight:650}
.nav-tabs>li.active>a,.nav-tabs>li.active>a:hover{border:0;background:#38BDF8;color:#0B1017}
.workspace{display:grid;grid-template-columns:minmax(200px,25%) minmax(0,1fr);gap:16px}
aside,.canvas,.summary{background:#1F2937;border:1px solid var(--line);border-radius:12px;padding:clamp(16px,2vw,30px);min-width:0}
h2{font:normal 29px/1.13 Georgia,serif;letter-spacing:-.03em;margin:0 0 20px}aside h2{font-size:23px}
.overline{color:var(--teal);margin:0 0 7px}label{font-weight:600;font-size:14px}.form-control{border-color:#64748B;border-radius:6px;height:40px;color:var(--ink)}
.method{padding-top:14px;border-top:1px solid var(--line);font-size:14px;color:#CBD5E1}small,footer{color:#CBD5E1}
.summary .table{max-width:680px}.summary td:last-child{font-variant-numeric:tabular-nums}footer{font-size:13px;flex-wrap:wrap}footer a{color:var(--teal)}
:focus-visible{outline:3px solid #38BDF8;outline-offset:2px}
@media(max-width:700px){.workspace{grid-template-columns:1fr}.signature{display:none}.hero{padding:24px 18px}.metric span{font-size:9px;letter-spacing:.04em}.metric{padding:12px 7px}.metric strong{font-size:19px}footer{justify-content:flex-start}.canvas{padding:14px 8px}}

:root{color-scheme:dark}
.form-control,.form-control option{background:#0B1017;color:#F3F4F6}
.nav-tabs>li>a:hover,.nav-tabs>li>a:focus{background:#334155;color:#F3F4F6}
.nav-tabs>li.active>a:focus{background:#38BDF8;color:#0B1017}
.table-striped>tbody>tr:nth-of-type(odd){background-color:#17202C}
.table>tbody>tr>td,.table>thead>tr>th{border-color:#374151}
#generate{background:#38BDF8;color:#0B1017;border:0;border-radius:6px;font-weight:700;padding:10px 18px;width:100%}
#generate:hover{background:#7DD3FC}
.js-plotly-plot .plotly .modebar{background:transparent!important}
.js-plotly-plot .plotly .modebar-btn path{fill:#CBD5E1!important}
)"

# I keep the original field names so I can trace each measure back to train.csv.
read_sales <- function(path) {
  sales <- read.csv(path, check.names = FALSE, stringsAsFactors = FALSE,
                    na.strings = c("NA", ""))
  required <- c("Id", "SalePrice", "YrSold", "GrLivArea", "Neighborhood",
                "OverallQual", "YearBuilt", "LotArea", "GarageArea", "TotalBsmtSF")
  stopifnot(all(required %in% names(sales)), !anyDuplicated(names(sales)),
            !anyDuplicated(sales$Id), all(is.finite(sales$SalePrice)))
  sales
}

views <- c("Histogram", "Density plot", "Frequency polygon", "Bar plot",
           "Scatter plot", "Box plot", "Line chart", "Area chart", "Correlation heatmap")
paired <- c("Scatter plot", "Box plot", "Line chart", "Area chart")
binned <- c("Histogram", "Frequency polygon")
heat_fields <- c("SalePrice", "GrLivArea", "OverallQual", "YearBuilt",
                 "LotArea", "GarageArea", "TotalBsmtSF")
labels <- c(GarageYrBlt = "Year garage was built", SalePrice = "Sale price (USD)", GrLivArea = "Living area (sq ft)",
            OverallQual = "Overall quality", YearBuilt = "Year built",
            LotArea = "Lot area (sq ft)", GarageArea = "Garage area (sq ft)",
            TotalBsmtSF = "Basement area (sq ft)", YrSold = "Year sold")
field_name <- function(x) ifelse(x %in% names(labels), unname(labels[x]), x)
choices_for <- function(x) setNames(x, field_name(x))
measures <- function(d) setdiff(names(d)[vapply(d, is.numeric, logical(1))],
                                c("Id", "MSSubClass"))
x_fields <- function(d, view) {
  if (view %in% c("Line chart", "Area chart")) return("YrSold")
  if (view %in% c("Bar plot", "Box plot"))
    return(c(names(d)[vapply(d, is.character, logical(1))], "MSSubClass"))
  measures(d)
}
format_number <- function(x) format(round(x, 2), big.mark = ",", trim = TRUE,
                                     scientific = FALSE)

# I count the same sales I use to draw the chart.
make_chart <- function(d, view, x, y, bins = 30L) {
  teal <- "#38BDF8"
  ink <- "#F3F4F6"
  axis_x <- axis_y <- ""
  if (view == "Correlation heatmap") {
    values <- na.omit(d[heat_fields])
    mat <- cor(values)
    p <- plot_ly(x = heat_fields, y = heat_fields, z = mat, type = "heatmap",
                 zmin = -1, zmax = 1, colorscale = list(list(0, "#a44542"),
                 list(0.5, "#1F2937"), list(1, teal)), colorbar = list(title = "r"),
                 hovertemplate = "%{y} × %{x}<br>Pearson r %{z:.2f}<extra></extra>")
    heading <- "How housing features move together"
    method <- "Pearson correlations across seven selected fields, using complete rows."
    count <- nrow(values)
  } else {
    stopifnot(x %in% x_fields(d, view))
    fields <- x
    if (view %in% paired) {
      stopifnot(y %in% measures(d), x != y)
      fields <- c(x, y)
    }
    rows <- complete.cases(d[fields])
    a <- d[[x]][rows]
    b <- if (view %in% paired) d[[y]][rows] else NULL
    count <- length(a)
    stopifnot(count > 1)
    axis_x <- field_name(x)
    axis_y <- if (view %in% paired) field_name(y) else "Sales"
    heading <- axis_x
    method <- "Counts use observed values in the selected field."
    if (view %in% binned) {
      edges <- seq(min(a), max(a), length.out = bins + 1L)
      h <- hist(a, breaks = edges, plot = FALSE, include.lowest = TRUE)
      if (view == "Histogram") {
        p <- plot_ly(x = h$mids, y = h$counts, width = diff(edges), type = "bar",
                     marker = list(color = teal), customdata = paste(format_number(head(edges,-1)),
                     "to", format_number(tail(edges,-1))), hovertemplate = "%{customdata}<br>%{y} sales<extra></extra>")
      } else {
        p <- plot_ly(x = h$mids, y = h$counts, type = "scatter", mode = "lines+markers",
                     line = list(color = teal))
      }
      method <- sprintf("%d equal-width intervals span the observed range.", bins)
    } else if (view == "Density plot") {
      curve <- density(a)
      p <- plot_ly(x = curve$x, y = curve$y, type = "scatter", mode = "lines",
                   fill = "tozeroy", line = list(color = teal))
      axis_y <- "Density"
      method <- "Gaussian kernel density estimate. The area under the curve is one."
    } else if (view == "Bar plot") {
      counts <- sort(table(a), decreasing = TRUE)
      p <- plot_ly(x = names(counts), y = as.numeric(counts), type = "bar",
                   marker = list(color = teal))
    } else if (view == "Scatter plot") {
      p <- plot_ly(x = a, y = b, type = "scatter", mode = "markers",
                   marker = list(size = 6, opacity = 0.55, color = teal))
      heading <- paste(axis_y, "by", axis_x)
      method <- "Each point represents a sale with both fields recorded."
    } else if (view == "Box plot") {
      p <- plot_ly(x = as.character(a), y = b, type = "box", color = I(teal))
      heading <- paste(axis_y, "by", axis_x)
      method <- "Boxes show the middle half of each group. The center line marks its median."
    } else {
      annual <- aggregate(b, list(year = a), median)
      fill <- if (view == "Area chart") "tozeroy" else "none"
      p <- plot_ly(x = annual$year, y = annual$x, type = "scatter", mode = "lines+markers",
                   line = list(color = teal, width = 3), fill = fill)
      heading <- paste("Annual median", axis_y)
      method <- "Each point is the median of observed sales in that calendar year."
    }
  }
  categorical <- view %in% c("Bar plot", "Box plot", "Correlation heatmap")
  horizontal <- list(title = axis_x, automargin = TRUE, nticks = 5,
                     type = if (categorical) "category" else "linear",
                     tickmode = "auto", gridcolor = "#374151")
  if (categorical) {
    groups <- switch(view, "Bar plot" = names(counts), "Box plot" = unique(as.character(a)),
                     "Correlation heatmap" = heat_fields)
    horizontal$categoryorder <- "array"
    horizontal$categoryarray <- groups
    horizontal$tickmode <- "array"
    horizontal$tickvals <- groups[seq(1, length(groups), by = ceiling(length(groups) / 7))]
    horizontal$tickangle <- -40
  } else if (x %in% c("GarageYrBlt", "YrSold", "YearBuilt", "YearRemodAdd")) {
    years <- pretty(range(a), n = 4)
    horizontal$tickmode <- "array"
    horizontal$tickvals <- unique(round(years[years >= min(a) & years <= max(a)]))
    horizontal$tickformat <- "d"
  }
  vertical <- list(title = axis_y, automargin = TRUE, nticks = 5, gridcolor = "#374151")
  if (view == "Density plot") vertical$tickformat <- ".2g"
  p <- layout(p, xaxis = horizontal, yaxis = vertical,
              margin = list(t = 12, l = 60, r = 22, b = 60), showlegend = FALSE,
              paper_bgcolor = "#1F2937", plot_bgcolor = "#1F2937",
              font = list(family = "Arial, sans-serif", color = ink))
  list(view = view, plot = config(p, displaylogo = FALSE, responsive = TRUE,
                     modeBarButtonsToRemove = list("sendDataToCloud")),
       title = heading, method = method, count = count)
}

# I open with the full sample so visitors can see the baseline before choosing a field.
build_ui <- function(d) {
  metric <- function(label, value) div(class = "metric", span(label), strong(value))
  prices <- hist(d$SalePrice, breaks = 22, plot = FALSE)$counts
  fluidPage(
    tags$head(tags$title("Data Insight | House prices"),
              tags$meta(name = "theme-color", content = "#0B1017"),
              tags$style(HTML(app_css))),
    div(class = "shell",
      tags$header(class = "mast", strong("Jibril Anifowoshe"), span("DATA INSIGHT")),
      div(class = "hero", div(
          h1("House price explorer"), p("Explore what homes sold for and how price varies with size, quality and neighborhood.")),
          div(class = "signature", title = "Distribution of observed sale prices",
              lapply(prices, function(n) tags$i(style = sprintf("height:%.2f%%", 100*n/max(prices)))))),
      div(class = "metrics", metric("Recorded sales", format_number(nrow(d))),
          metric("Median sale price", paste0("$", format_number(median(d$SalePrice)))),
          metric("Sale years", paste(range(d$YrSold), collapse = " – "))),
      tabsetPanel(id = "section",
        tabPanel("Explore", div(class = "workspace",
          tags$aside(h2("Chart settings"), selectInput("view", "View", views, selectize = FALSE),
            conditionalPanel("['Histogram','Density plot','Frequency polygon'].includes(input.view)",
              selectInput("measure", "Horizontal field", choices_for(measures(d)), "SalePrice", selectize = FALSE)),
            conditionalPanel("input.view === 'Scatter plot'",
              selectInput("scatter_x", "Horizontal field", choices_for(measures(d)), "GrLivArea", selectize = FALSE)),
            conditionalPanel("['Bar plot','Box plot'].includes(input.view)",
              selectInput("group", "Horizontal field", choices_for(x_fields(d, "Bar plot")), "Neighborhood", selectize = FALSE)),
            conditionalPanel("['Line chart','Area chart'].includes(input.view)", p("Horizontal field: Year sold")),
            conditionalPanel("['Scatter plot','Box plot','Area chart','Line chart'].includes(input.view)",
              selectInput("y", "Vertical field", choices_for(measures(d)), "SalePrice", selectize = FALSE)),
            conditionalPanel("input.view === 'Histogram' || input.view === 'Frequency polygon'",
              numericInput("bins", "Intervals", 30, min = 5, max = 80)),
            actionButton("generate", "Generate Chart"),
            tags$small("Select Generate Chart to apply your settings.")),
          tags$section(class = "canvas", p(class = "overline", textOutput("kind", inline = TRUE)),
            h2(textOutput("heading", inline = TRUE)),
            plotlyOutput("figure", height = "430px"),
            div(class = "method", textOutput("caption"))))),
        tabPanel("Data summary", div(class = "summary", h2("Field profile"),
          selectInput("field", "Inspect a field", names(d), selected = "SalePrice", selectize = FALSE),
          tableOutput("profile"), p("NA in the source can indicate an absent feature or an unrecorded value. Interpret each field in context.")))),
      tags$footer(strong("Built and designed by Jibril Anifowoshe"),
        tags$a(href = "https://github.com/Jibril-ctrl/HousePrice-ShinyApp", "Project source"))))
}

build_server <- function(d) {
  function(input, output, session) {
    # I keep the selectors mounted so switching views preserves the last field in each group.
    selected_x <- reactive(switch(input$view, "Bar plot" = input$group, "Box plot" = input$group,
      "Scatter plot" = input$scatter_x, "Area chart" = "YrSold", "Line chart" = "YrSold",
      "Correlation heatmap" = NULL, input$measure))
    result <- reactiveVal(make_chart(d, "Histogram", "SalePrice", NULL, 30L))
    observeEvent(input$generate, {
      view <- req(input$view)
      req(view %in% views)
      if (view != "Correlation heatmap") req(selected_x() %in% x_fields(d, view))
      if (view %in% paired) {
        req(input$y %in% measures(d))
        if (selected_x() == input$y) {
          showNotification("Choose two different fields.", type = "warning")
          return()
        }
      }
      if (view %in% binned && !(length(input$bins) == 1 && is.finite(input$bins) &&
          input$bins >= 5 && input$bins <= 80 && input$bins == floor(input$bins))) {
        showNotification("Choose a whole number from 5 to 80.", type = "warning")
        return()
      }
      result(make_chart(d, view, selected_x(), input$y, input$bins))
    }, ignoreInit = FALSE)
    output$kind <- renderText(result()$view)
    output$figure <- renderPlotly(result()$plot)
    output$heading <- renderText(result()$title)
    output$caption <- renderText(paste0(result()$method, "  ",
      format_number(result()$count), " of ", format_number(nrow(d)), " sales included."))
    output$profile <- renderTable({
      req(input$field %in% names(d))
      x <- d[[input$field]]
      present <- x[!is.na(x)]
      values <- c("Recorded" = length(present), "Source NA" = sum(is.na(x)),
                  "Distinct recorded values" = length(unique(present)))
      if (is.numeric(x)) {
        values <- c(values, Minimum = min(present), Q1 = unname(quantile(present, .25)),
                    Median = median(present), Mean = mean(present),
                    Q3 = unname(quantile(present, .75)), Maximum = max(present))
        return(data.frame(Statistic = names(values), Value = format_number(values)))
      }
      counts <- sort(table(present), decreasing = TRUE)
      data.frame(Statistic = c(names(values), paste("Count ·", names(counts))),
                 Value = format_number(c(values, as.numeric(counts))))
    }, striped = TRUE, spacing = "s")
  }
}

# I load the sales file once and give each visitor their own chart settings.
sales <- read_sales("train.csv")
shinyApp(build_ui(sales), build_server(sales))
