# Shiny app example

This basic application shows some of the main features of the shiny package.

It allows users to visualize the percentage contribution of the items of the Canadian basket of goods and services to the overall Consumer Price Index for the provinces of Ontario, Alberta and Quebec. 

The application is hosted [here](https://mmala027.shinyapps.io/myapp/) with a small presentation hosted through [Rpubs](http://rpubs.com/mmala027/price).

The application can be ran from RStudio using the following code:

```
## Installing missing packages
pkgs <- c("shiny", "dplyr", "DT", "ggplot2", "plotly")

pkgs_needed <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]

if(length(pkgs_needed)) install.packages(pkgs_needed)

## Run app from Github repo
shiny::runGitHub('manolo20/priceweights')

```
