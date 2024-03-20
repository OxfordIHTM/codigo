# Test autocode function -------------------------------------------------------

testthat::expect_s3_class(
  icd_autocode_foundation("colorectal cancer"),
  "tbl_df"
)

testthat::expect_message(
  icd_autocode_foundation("colorectal cancer")
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
