library(broom)
library(stargazer)

dat = read.csv("./data/result.csv")

lin_mod = lm(data = dat, "DFE ~ . -Country.Name - Country.Code")
stargazer(lin_mod, title = "DFE on all other variables",
 type = "latex", out = "./output/all_lm.tex")

welfare_mod = lm(data = dat, "DFE ~ perc_tot_welfare + contrac_prev + 
 cov_social_insur + gdp_pc_ppp")
tidy(welfare_mod)
stargazer(welfare_mod, title = "DFE on welfare-related variables",
 type = "latex", out = "./output/welfare_lm.tex")

health_mod = lm(data = dat,"DFE ~ life_exp_birth + mortality_rate + gdp_pc_ppp")
summary(health_mod)
stargazer(health_mod, title = "DFE on health-related variables",
 type = "latex", out = "./output/health_lm.tex")

hiv_mod = lm(data = dat,"DFE ~ hiv_prev + gdp_pc_ppp")
summary(hiv_mod)
stargazer(lin_mod, title = "DFE on HIV prevalence",
 type = "latex", out = "./output/hiv_lm.tex")
