# Tests for icd_map function ---------------------------------------------------

testthat::test_that(
  "output class/type and structure is as expected", {
    expect_s3_class(icd_map(code = "A00"), "tbl")
    expect_length(nrow(icd_map(code = "A00")), 1)
    expect_named(
      icd_map(code = "A00"),
      expected = names(ten_map_to_one_eleven)
    )
    expect_s3_class(icd_map(from = "icd11", code = "1A00"), "tbl")
    expect_length(nrow(icd_map(from = "icd11", code = "1A00")), 1)
    expect_named(
      icd_map(from = "icd11", code = "1A00"),
      expected = names(ten_map_to_one_eleven)
    )
  }
)

