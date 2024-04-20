library(broom)
library(stargazer)

dat = read.csv("./data/result.csv")

# Regression of DFE on all variables
lin_mod = lm(data = dat, "DFE ~ . -Country.Name - Country.Code")
stargazer(lin_mod, title = "DFE on all other variables",
 dep.var.labels = "Droughts, floods, extreme temperatures",
 type = "latex", out = "./output/all_lm.tex")

# Regression of DFE on welfare-related variables
welfare_mod = lm(data = dat, "DFE ~ perc_tot_welfare + contrac_prev + 
 cov_social_insur + gdp_pc_ppp")
summary(welfare_mod)
stargazer(welfare_mod, title = "DFE on welfare-related variables",
 dep.var.labels = "Droughts, floods, extreme temperatures",
 type = "latex", out = "./output/welfare_lm.tex")

# Regression of DFE on health-related variables
health_mod = lm(data = dat,"DFE ~ life_exp_birth + mortality_rate + gdp_pc_ppp")
summary(health_mod)
stargazer(health_mod, title = "DFE on health-related variables",
 dep.var.labels = "Droughts, floods, extreme temperatures",
 type = "latex", out = "./output/health_lm.tex")

# Regression of DFE on hiv, controlling for gdp
hiv_mod = lm(data = dat,"DFE ~ hiv_prev + gdp_pc_ppp")
summary(hiv_mod)
stargazer(hiv_mod, title = "DFE on HIV prevalence",
 dep.var.labels = "Droughts, floods, extreme temperatures",
 type = "latex", out = "./output/hiv_lm.tex")

# Regression of DFE on variables with decent no. observations
int_mod = lm(data = dat,"DFE ~ contrac_prev + fertility_rate +
     + gdp_pc_ppp + life_exp_birth + mortality_rate + school_enrol_pri_sec +
     school_enrol_tert")
summary(int_mod)
stargazer(int_mod, title = "DFE on Selected Variables with no. Obs greater than 150",
 dep.var.labels = "Droughts, floods, extreme temperatures",
 type = "latex", out = "./output/interesting_lm.tex")

stargazer(lin_mod, welfare_mod, health_mod, hiv_mod,
 title = "Regression Models Summary", 
 dep.var.labels = "Droughts, floods, extreme temperatures",
 column.labels = c("All", "Welfare", "Health", "HIV"),
 type = "latex", out = "./output/lmsummary.tex")