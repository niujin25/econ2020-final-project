# econ2020-final-project

## Data Download

- climate: World Bank, [Droughts, floods, extreme temperatures (% of population, average 1990-2009)](https://data.worldbank.org/indicator/EN.CLC.MDAT.ZS)
    - Click "Download csv"

- world development indicators: World Bank, [World Development Indicators](https://databank.worldbank.org/source/world-development-indicators/Type/TABLE/preview/on#)
    - Database: World Development Index
    - Country: select all (266)
    - Series: make selections of 14 variables listed below (besides DFE)
    - Time: 1990 to 2009
    - Layout: Time - row; Series - column; Country - row
    - Download options: csv

The following table lists the variable names and their corresponding shortened variable names appearing in all outputs.

|                                                    Variables                                                    |     Abbreviations    |
|:---------------------------------------------------------------------------------------------------------------:|:--------------------:|
| Droughts, floods, extreme temperatures (% of population, average 1990-2009)                                     | DFE                  |
| Adequacy of social insurance programs (% of total welfare of beneficiary households) [per_si_allsi.adq_pop_tot] | perc_tot_welfare     |
| Adjusted net national income per capita (constant 2015 US$) [NY.ADJ.NNTY.PC.KD]                                 | net_income_pc        |
| Contraceptive prevalence, any method (% of married women ages 15-49) [SP.DYN.CONU.ZS]                           | contrac_prev         |
| Coverage of social insurance programs (% of population) [per_si_allsi.cov_pop_tot]                              | cov_social_insur     |
| CPIA gender equality rating (1=low to 6=high) [IQ.CPA.GNDR.XQ]                                                  | cpia_gender_rating   |
| Fertility rate, total (births per woman) [SP.DYN.TFRT.IN]                                                       | fertility_rate       |
| GDP per capita, PPP (constant 2017 international $) [NY.GDP.PCAP.PP.KD]                                         | gdp_pc_ppp           |
| Income share held by lowest 20% [SI.DST.FRST.20]                                                                | income_share_low20   |
| Life expectancy at birth, total (years) [SP.DYN.LE00.IN]                                                        | life_exp_birth       |
| Literacy rate, youth (ages 15-24), gender parity index (GPI) [SE.ADT.1524.LT.FM.ZS]                             | literacy_rate        |
| Mortality rate, under-5 (per 1,000 live births) [SH.DYN.MORT]                                                   | mortality_rate       |
| Prevalence of HIV, total (% of population ages 15-49) [SH.DYN.AIDS.ZS]                                          | hiv_prev             |
| School enrollment, primary and secondary (gross), gender parity index (GPI) [SE.ENR.PRSC.FM.ZS]                 | school_enrol_pri_sec |
| School enrollment, tertiary (gross), gender parity index (GPI) [SE.ENR.TERT.FM.ZS]                              | school_enrol_tert    |

The raw data files are manually pasted into the `data` folder.

**Note**: All necessary packages are installed within `renv`. One should run `renv::restore` to set up everything as the first step.

1. `clean_data.r`: takes raw csvs, clean them, and save them as clean datasets into the same folder.
    - output (`data` folder): `clean_climate.csv`, `clean_wdi.csv`, `clean_result.csv`.

2. `figures.r`: takes cleaned data files from `data` folder from previous step, makes tables and graphs.
    - output (`output` folder):

