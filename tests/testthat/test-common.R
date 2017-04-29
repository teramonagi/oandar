context("common.R")

test_that("is_empty()", {
  expect_false(is_empty("hoge"))
  expect_true(is_empty(""))
  expect_true(is_empty(NULL))
})

