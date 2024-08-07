# Test autocode function -------------------------------------------------------

## Autocode foundation ----

testthat::expect_s3_class(
  icd_autocode_foundation("colorectal cancer"),
  "tbl_df"
)

testthat::expect_s3_class(
  icd_autocode_foundation("colorectal cancer", release = "2024-01"),
  "tbl_df"
)

testthat::expect_message(
  icd_autocode_foundation("colorectal cancer")
)

testthat::expect_error(
  icd_autocode_foundation("colorectal cancer", release = "2025-01")
)

testthat::expect_no_message(
  icd_autocode_foundation("colorectal cancer", verbose = FALSE)
)

testthat::expect_type(
  icd_autocode_foundation("colorectal cancer", tabular = FALSE),
  "list"
)

testthat::expect_s3_class(
  icd_autocode_foundation("colorectal cancer", threshold = 1),
  "tbl_df"
)

## Autocode linearisation - mms ----

testthat::expect_s3_class(
  icd_autocode("colorectal cancer"),
  "tbl_df"
)

testthat::expect_message(
  icd_autocode("colorectal cancer")
)

testthat::expect_error(
  icd_autocode("colorectal cancer", release = "2025-01")
)

testthat::expect_no_message(
  icd_autocode("colorectal cancer", verbose = FALSE)
)

testthat::expect_type(
  icd_autocode("colorectal cancer", tabular = FALSE),
  "list"
)

testthat::expect_s3_class(
  icd_autocode("colorectal cancer", threshold = 1),
  "tbl_df"
)
