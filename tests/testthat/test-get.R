# Tests for get functions ------------------------------------------------------

## Test default call ----
test_get_foundation_default <- icd_get_foundation()

testthat::expect_s3_class(test_get_foundation_default, "tbl_df")
testthat::expect_type(test_get_foundation_default, "list")

## Test release ----
test_get_foundation_release <- icd_get_foundation(release = "2024-01")

testthat::expect_s3_class(test_get_foundation_release, "tbl_df")
testthat::expect_type(test_get_foundation_release, "list")
