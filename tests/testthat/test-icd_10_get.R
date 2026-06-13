# Tests for ICD-10 endpoints ---------------------------------------------------

testthat::test_that(
  "icd_10_get_releases() returns a list", {
    skip_if_no_icd_api()
    expect_type(icd_10_get_releases(), "list")
  }
)

testthat::test_that(
  "icd_10_get_chapters() returns a list", {
    skip_if_no_icd_api()
    release_chapters <- icd_10_get_chapters()
    expect_type(release_chapters, "list")
  }
)

testthat::test_that(
  "expect warning or error", {
    skip_if_no_icd_api()
    expect_error(icd_10_get_chapters(release = 2020))
    expect_warning(icd_10_get_chapters(language = "fr"))
  }
)

testthat::test_that(
  "icd_10_get_release_by_category() returns a list", {
    skip_if_no_icd_api()
    release_category <- icd_10_get_release_by_category("A00")
    expect_type(release_category, "list")
  }
)

testthat::test_that(
  "release_info is of the right type", {
    skip_if_no_icd_api()
    release_info <- icd_10_get_info(category = "A00")
    expect_type(release_info, "list")
  }
)

testthat::test_that(
  "warning is raised for unavailable language", {
    skip_if_no_icd_api()
    expect_warning(icd_10_get_info(category = "A00", language = "zz"))
  }
)

testthat::test_that(
  "error is raised for unavailable release", {
    skip_if_no_icd_api()
    expect_error(icd_10_get_info(category = "A00", release = 2020))
  }
)
