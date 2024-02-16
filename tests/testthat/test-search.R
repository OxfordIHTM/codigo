# Test search function/s -------------------------------------------------------

test_search_default <- icd_search_foundation(q = "cholera")

## Test message ----
testthat::expect_message(icd_search_foundation(q = "cholera"))
testthat::expect_s3_class(test_search_default, "tbl_df")
testthat::expect_type(test_search_default, "list")

## Test no message ----
testthat::expect_no_message(icd_search_foundation(q = "cholera", verbose = FALSE))

## Test list output ----
test_search_list <- icd_search_foundation(q = "cholera", tabular = FALSE)

testthat::expect_type(test_search_list, "list")

## Test release specification ----
test_search_release <- icd_search_foundation(q = "cholera", release = "2024-01")
testthat::expect_message(icd_search_foundation(q = "cholera", release = "2024-01"))
testthat::expect_s3_class(test_search_release, "tbl_df")
testthat::expect_type(test_search_release, "list")
testthat::expect_error(icd_search_foundation(q = "cholera", release = "2025-01"))

