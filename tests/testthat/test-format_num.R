test_that("format_num() formats pi correctly", {
  pi_2_dec <- "3,14"
  pi_4_dec <- "3,1416"
  pi_round_off <- "3,141593"

  expect_equal(format_num(pi), pi_2_dec)
  expect_equal(format_num(pi, 2), pi_2_dec)
  expect_equal(format_num(pi, 2), format_num(pi))

  expect_equal(format_num(pi, 4), pi_4_dec)
  expect_equal(format_num(pi, rounding = FALSE), pi_round_off)

  expect_error(format_num(pi, 4, rounding = FALSE))

})

test_that("format_num() throws error when given wrong types", {

  double <- 3.1415
  string <- as.character("3,1415")
  df <- data.frame()

  expect_error(format_num(string))
  expect_error(format_num(df))

  expect_no_error(format_num(double))

})
