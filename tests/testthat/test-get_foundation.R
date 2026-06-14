# Tests for get foundation functions -------------------------------------------

## Test default call ----

testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    test_get_foundation_default <- icd_get_foundation()
    testthat::expect_s3_class(test_get_foundation_default, "tbl_df")
    testthat::expect_type(test_get_foundation_default, "list")
  }
)

## Test non-tabular call ----

testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    test_get_foundation_list <- icd_get_foundation(tabular = FALSE)
    testthat::expect_type(test_get_foundation_list, "list")
  }
)

## Test warning for unavailable language ----

testthat::test_that(
  "a warning is raised for language not found", {
    skip_if_no_icd_api()
    testthat::expect_warning(icd_get_foundation(language = "zz"))
  }
)

## Test release ----

testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    test_get_foundation_release <- icd_get_foundation(release = "2024-01")
    testthat::expect_s3_class(test_get_foundation_release, "tbl_df")
    testthat::expect_type(test_get_foundation_release, "list")
  }
)

testthat::test_that(
  "an error is raised for unavailable icd release", {
    skip_if_no_icd_api()
    testthat::expect_error(icd_get_foundation(release = "2020"))
  }
)


## Test default entity call ----

testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    test_get_entity_default <- icd_get_foundation_entity("1435254666")
    testthat::expect_s3_class(test_get_entity_default, "tbl_df")
    testthat::expect_type(
      icd_get_foundation_entity("1435254666", tabular = FALSE), "list"
    )
  }
)

testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    test_get_entity_release <- icd_get_foundation_entity(
      "1435254666", release = "2024-01"
    )
    testthat::expect_s3_class(test_get_entity_release, "tbl_df")
  }
)


testthat::test_that(
  "output class/type is as expected", {
    skip_if_no_icd_api()
    test_get_entity_include <- icd_get_foundation_entity(
      id = "1435254666",
      include = c("ancestor", "descendant", "diagnosticCriteria")
    )
    testthat::expect_s3_class(test_get_entity_include, "tbl_df")
    testthat::expect_true(
      all(c("ancestor", "descendant") %in% names(test_get_entity_include))
    )
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    skip_if_no_icd_api()
    testthat::expect_warning(
      icd_get_foundation_entity(id = "1435254666", language = "zz")
    )
  }
)
