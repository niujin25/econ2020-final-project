# Install package to get climate data from World Bank
# install.packages("WDI")
# remotes::install_github("vincentarelbundock/WDI")

require(remotes)
library(WDI, help, pos = 2, lib.loc = NULL)
WDIsearch("gdp")
