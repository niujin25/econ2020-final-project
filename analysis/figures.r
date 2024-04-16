library(stargazer)
library(ggplot2)

dat = read.csv("./data/result.csv")


# summary statistics for response and covariables
dat[, 3: 17] |> stargazer(type = "text")

# make graphs
dat |> ggplot(aes(x = DFE)) + geom_histogram()  + theme_bw()

### climate and output / income
dat |> ggplot(aes(x = DFE, y = gdp_pc_ppp)) + geom_point() + theme_bw()

dat |> ggplot(aes(x = DFE, y = net_income_pc)) + geom_point() + theme_bw()

### climate and health
dat |> ggplot(aes(x = DFE, y = life_exp_birth)) + geom_point() +
    geom_smooth(method = "lm", se = TRUE)
dat |> ggplot(aes(x = DFE, y = mortality_rate)) + geom_point() +
    geom_smooth(method = "lm", se = TRUE)

### climate and social welfare
dat |> ggplot(aes(x = DFE, y = perc_tot_welfare)) + geom_point() +
    geom_smooth(method = "lm", se = TRUE)

dat |> ggplot(aes(x = DFE, y = cov_social_insur)) + geom_point() +
    geom_smooth(method = "lm", se = TRUE)

dat |> ggplot(aes(x = DFE, y = literacy_rate)) + geom_point() +
    geom_smooth(method = "lm", se = TRUE)

dat |> ggplot(aes(x = DFE, y = school_enrol_pri_sec)) + geom_point() +
    geom_smooth(method = "lm", se = TRUE)

dat |> ggplot(aes(x = DFE, y = school_enrol_tert)) + 
    geom_point(aes(color = gdp_pc_ppp)) + scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE) + theme_bw()
