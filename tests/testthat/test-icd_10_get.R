# Tests for ICD-10 endpoints ---------------------------------------------------

release_result <- icd_10_get_releases()

testthat::test_that(
  "release_result is of the right type", {
    expect_type(release_result, "list")
  }
)


release_chapters <- icd_10_get_chapters()

testthat::test_that(
  "release_chapters is of the right type", {
    expect_type(release_chapters, "list")
  }
)

testthat::test_that(
  "expect warning or error", {
    expect_error(icd_10_get_chapters(release = 2020))
    expect_warning(icd_10_get_chapters(language = "fr"))
  }
)
