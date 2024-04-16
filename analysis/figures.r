library(stargazer)
library(ggplot2)
library(patchwork)

dat = read.csv("./data/result.csv")


# summary statistics for response and covariables
dat[, 3: 17] |> stargazer(type = "text")

# make graphs

### climate severity distribution
cli <- dat |> ggplot(aes(x = DFE)) + geom_histogram()  + theme_bw()

### climate and output / income
gdp <- dat |> ggplot(aes(x = DFE, y = gdp_pc_ppp)) +
    geom_point() + theme_bw() +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise')

### climate and health
liexp <- dat |> ggplot(aes(x = DFE, y = life_exp_birth)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    scale_color_gradient(low = "black", high = "red") + theme_bw() +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise')

mort <- dat |> ggplot(aes(x = DFE, y = mortality_rate)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    scale_color_gradient(low = "black", high = "red") + theme_bw() +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise')

### climate and social welfare
totwel <- dat |> ggplot(aes(x = DFE, y = perc_tot_welfare)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE)

socins <- dat |> ggplot(aes(x = DFE, y = cov_social_insur)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE)

prisec <- dat |> ggplot(aes(x = DFE, y = school_enrol_pri_sec)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise') + theme_bw()

ter <- dat |> ggplot(aes(x = DFE, y = school_enrol_tert)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise') + theme_bw()

# outputting plots combined or singletons, using patchwork
ggsave("./output/climate_dist.pdf", cli, width = 4, height = 4, units = "in")

ggsave("./output/climate_gdp.pdf", gdp, width = 5, height = 6, units = "in")

health <- liexp + mort + plot_layout(guides = "collect") 
ggsave("./output/climate_health.pdf", health, 
    width = 12, height = 10, units = "in")


welfare <- ((totwel / prisec + plot_layout(axis_titles = "collect")) | 
    (socins / ter) + plot_layout(axis_titles = "collect")) + 
    plot_layout(guides = "collect")
ggsave("./output/climate_welfare.pdf", welfare,
    width = 10, height = 10, units = "in")
