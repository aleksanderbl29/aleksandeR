test_that("format_num() formats pi correctly", {
  pi_2_dec <- "3,14"
  pi_4_dec <- "3,1416"
  pi_4_dec_round_off <- "3,1415"

  expect_equal(format_num(pi), pi_2_dec)
  expect_equal(format_num(pi, 2), pi_2_dec)
  expect_equal(format_num(pi, 2), format_num(pi))

  expect_equal(format_num(pi, 4), pi_4_dec)
  expect_error(format_num(pi, 4, rounding = FALSE))
  expect_equal(format_num(pi, 4), pi_4_dec_round_off)

})

test_that("format_num() throws error when given wrong types", {

  double <- 3.1415
  string <- as.character("3,1415")


  expect_error(format_num(string))

  expect_no_error(format_num(double))

})
