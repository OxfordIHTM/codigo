# Test autocode function -------------------------------------------------------

testthat::expect_s3_class(
  icd_autocode_foundation("colorectal cancer"),
  "tbl_df"
)

testthat::expect_message(
  icd_autocode_foundation("colorectal cancer")
)

testthat::expect_error(
  icd_autocode_foundation("colorectal cancer", release = "2025-01")
)

