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
    geom_text(aes(label = ifelse(gdp_pc_ppp > 25000 &
        DFE > 2.5, Country.Name, "")), vjust = -1) + 
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise')

### climate and health
liexp <- dat |> ggplot(aes(x = DFE, y = life_exp_birth)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    geom_text(aes(label = ifelse(life_exp_birth > 70 &
        DFE > 2.5, Country.Name, "")), vjust = -1) + 
    scale_color_gradient(low = "black", high = "red") + theme_bw() +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise')

mort <- dat |> ggplot(aes(x = DFE, y = mortality_rate)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    geom_text(aes(label = ifelse(mortality_rate > 200, 
     Country.Name, "")), vjust = -1, hjust = 0) + 
    scale_color_gradient(low = "black", high = "red") + theme_bw() +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise')

### climate and social welfare
totwel <- dat |> ggplot(aes(x = DFE, y = perc_tot_welfare)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE)

socins <- dat |> ggplot(aes(x = DFE, y = cov_social_insur)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    geom_text(aes(label = ifelse(cov_social_insur > 40 &
        DFE > 2.5, Country.Name, "")), vjust = -1) + 
    scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE)

prisec <- dat |> ggplot(aes(x = DFE, y = school_enrol_pri_sec)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    geom_text(aes(label = ifelse(school_enrol_pri_sec < 0.6, Country.Name, "")), vjust = -1) + 
    scale_color_gradient(low = "black", high = "red") +
    geom_smooth(method = "lm", se = TRUE, color = 'turquoise') + theme_bw()

ter <- dat |> ggplot(aes(x = DFE, y = school_enrol_tert)) +
    geom_point(aes(color = gdp_pc_ppp)) +
    geom_text(aes(label = ifelse(school_enrol_tert < 0.2 |
        school_enrol_tert > 1 & DFE > 5, Country.Name, "")), vjust = -1) + 
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
    width = 14, height = 14, units = "in")
