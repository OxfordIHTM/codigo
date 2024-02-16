# Tests for get functions ------------------------------------------------------

## Test default call ----
test_get_foundation_default <- icd_get_foundation()

testthat::expect_s3_class(test_get_foundation_default, "tbl_df")
testthat::expect_type(test_get_foundation_default, "list")

