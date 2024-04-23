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


release_category <- icd_10_get_release_by_category("A00")

testthat::test_that(
  "release_category is of the right type", {
    expect_type(release_category, "list")
  }
)


release_info <- icd_10_get_info(category = "A00")

testthat::test_that(
  "release_info is of the right type", {
    expect_type(release_info, "list")
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    expect_warning(icd_10_get_info(category = "A00", language = "zz"))
  }
)

testthat::test_that(
  "error is raised for unavailable release", {
    expect_error(icd_10_get_info(category = "A00", release = 2020))
  }
)
