## Run all code for the project

## Get raw data
# need to get them manually

## Clean Data
source("./data/clean_data.r")

## Make Summary Table and Figures
source("./analysis/figures.r")

## Run Analysis
source("./analysis/analysis.r")

## Run Tests
library(testdat)
testthat::local_edition(3)
testthat::test_dir("tests")