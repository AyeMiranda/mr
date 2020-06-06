context("My forint function")
library(mr)
library(testthat)

test_that("Test forint function", {
  expect_equal(forint(42), '42Ft')
})
