# Tests for get functions ------------------------------------------------------

## Test default call ----
test_get_foundation_default <- icd_get_foundation()

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_s3_class(test_get_foundation_default, "tbl_df")
    testthat::expect_type(test_get_foundation_default, "list")
  }
)

## Test non-tabular call ----
test_get_foundation_list <- icd_get_foundation(tabular = FALSE)

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_type(test_get_foundation_list, "list")
  }
)

## Test warning for unavailable language ----

testthat::test_that(
  "a warning is raised for language not found", {
    testthat::expect_warning(icd_get_foundation(language = "zz"))
  }
)

## Test release ----
test_get_foundation_release <- icd_get_foundation(release = "2024-01")

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_s3_class(test_get_foundation_release, "tbl_df")
    testthat::expect_type(test_get_foundation_release, "list")
  }
)

testthat::test_that(
  "an error is raised for unavailable icd release", {
    testthat::expect_error(icd_get_foundation(release = "2020"))
  }
)


## Test default entity call ----

test_get_entity_default <- icd_get_entity("1435254666")

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_type(test_get_entity_default, "list")
  }
)

test_get_entity_release <- icd_get_entity("1435254666", release = "2024-01")

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_type(test_get_entity_release, "list")
  }
)

test_get_entity_include <- icd_get_entity(
  id = "1435254666",
  include = c("ancestor", "descendant", "diagnosticCriteria")
)

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_type(test_get_entity_include, "list")
    testthat::expect_true(
      all(c("ancestor", "descendant") %in% names(test_get_entity_include))
    )
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    testthat::expect_warning(icd_get_entity(id = "1435254666", language = "zz"))
  }
)

## Test icd_get_info ----

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_type(icd_get_info(), "list")
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    testthat::expect_warning(icd_get_info(language = "zz"))
  }
)

## Test icd_get_chapter ----

testthat::test_that(
  "output class/type is as expected", {
    testthat::expect_type(icd_get_chapter(release = "2023-01"), "list")
    testthat::expect_type(icd_get_chapter(), "list")
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    testthat::expect_warning(icd_get_chapter(language = "zz"))
  }
)


