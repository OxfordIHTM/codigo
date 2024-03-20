# Tests for get functions ------------------------------------------------------

## Test default call ----
test_get_foundation_default <- icd_get_foundation()

testthat::expect_s3_class(test_get_foundation_default, "tbl_df")
testthat::expect_type(test_get_foundation_default, "list")

## Test non-tabular call ----
test_get_foundation_list <- icd_get_foundation(tabular = FALSE)

testthat::expect_type(test_get_foundation_list, "list")


## Test release ----
test_get_foundation_release <- icd_get_foundation(release = "2024-01")

testthat::expect_s3_class(test_get_foundation_release, "tbl_df")
testthat::expect_type(test_get_foundation_release, "list")

## Test default entity call ----

test_get_entity_default <- icd_get_entity("1435254666")
testthat::expect_type(test_get_entity_default, "list")

test_get_entity_release <- icd_get_entity("1435254666", release = "2024-01")
testthat::expect_type(test_get_entity_release, "list")

test_get_entity_include <- icd_get_entity(
  id = "1435254666",
  include = c("ancestor", "descendant", "diagnosticCriteria")
)
testthat::expect_type(test_get_entity_include, "list")
testthat::expect_true(
  all(c("ancestor", "descendant") %in% names(test_get_entity_include))
)

## Test icd_get_info ----

testthat::expect_type(icd_get_info(), "list")

## Test icd_get_chapter ----

testthat::expect_type(icd_get_chapter(release = "2023-01"), "list")
testthat::expect_type(icd_get_chapter(), "list")



