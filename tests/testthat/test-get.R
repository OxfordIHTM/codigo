# Tests for get functions ------------------------------------------------------

## Test icd_get_info ----

testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    testthat::expect_type(icd_get_info(), "list")
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    skip_if_no_icd_api()
    testthat::expect_warning(icd_get_info(language = "zz"))
  }
)

## Test icd_get_chapter ----

testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    testthat::expect_type(icd_get_chapter(release = "2023-01"), "list")
    testthat::expect_type(icd_get_chapter(), "list")
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    skip_if_no_icd_api()
    testthat::expect_warning(icd_get_chapter(language = "zz"))
  }
)
