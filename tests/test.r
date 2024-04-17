library(testthat)
library(testdat)

# Your test code here

test_that("Test cleaned dataset",{
    expect_unique(Country.Code, data = dat)
    expect_range(c(perc_tot_welfare, contrac_prev, cov_social_insur,
        fertility_rate, income_share_low20, hiv_prev),
        0, 100, data = dat)
    expect_range(cpia_gender_rating, 1, 6, data = dat)
})

test_that("Test linear regression model", {
  expect_true(unname(coef(lin_mod)['gdp_pc_ppp']) < 0)
  expect_true(unname(coef(hiv_mod)['hiv_prev']) > 0)
})
