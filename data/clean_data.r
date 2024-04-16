
library(tidyverse)
library(readr)

climate <- read_csv("./data/API_EN.CLC.MDAT.ZS_DS2_en_csv_v2_45415.csv",
                    skip = 4) |> select(c(1:2, `2009`)) |>
                    filter(!is.na(`2009`)) |>
                    rename("DFE" = "2009")
climate |> print()

# write.csv(climate, "./data/clean_climate.csv", row.names = FALSE)

wdi <- read_csv("./data/28ae28fe-02a0-45ab-89c6-591a2e389a54_Data.csv") |>
                filter(!is.na(`Country Name`)) |>
                select(-`Time Code`) |>

                # replace ".." with "NA"
                mutate(across(everything(), ~ ifelse(. == "..", NA, .))) |>

                # change data type to dbl
                mutate(across(c(1, 4:17), as.numeric)) |>

                # remove all rows where all of its variables are NA, and keep only dates before 2009
                filter(!if_all(4:17, is.na), Time <= 2009) |>
                rename_all(funs(c("time", "country", "country_code", "perc_tot_welfare",
                "net_income_pc", "contrac_prev", "cov_social_insur", "cpia_gender_rating",
                "fertility_rate", "gdp_pc_ppp", "income_share_low20", "life_exp_birth",
                "literacy_rate", "mortality_rate", "hiv_prev", "school_enrol_pri_sec",
                "school_enrol_tert")))

# write.csv(wdi, "./data/clean_wdi.csv", row.names = FALSE)

covariates = colnames(wdi)[4:17]

# calculate average values for covariates across years 1990-2009
wdi_result <- wdi |> group_by(country_code) |>
            summarise_at(covariates, mean, na.rm = TRUE)


combined <- climate |> inner_join(wdi_result, 
                        by = c(`Country Code` = "country_code"))

write.csv(combined, "./data/result.csv", row.names = FALSE)