# Tests for utility functions --------------------------------------------------

## Test get releases default ----
test_get_releases <- icd_get_releases()

testthat::expect_s3_class(test_get_releases, "tbl_df")
testthat::expect_type(test_get_releases, "list")


## Test get releases NULL ----
test_get_releases <- icd_get_releases(icd = NULL)

testthat::expect_s3_class(test_get_releases, "tbl_df")
testthat::expect_type(test_get_releases, "list")


## Test get releases icd-10 ----

test_get_releases_icd10 <- icd_get_releases("icd10")

testthat::expect_s3_class(test_get_releases_icd10, "tbl_df")
testthat::expect_type(test_get_releases_icd10, "list")


## Test get releases latest ----
test_get_release_latest <- icd_get_releases(latest = TRUE)

testthat::expect_s3_class(test_get_release_latest, "tbl_df")
testthat::expect_type(test_get_release_latest, "list")


## Test get releases latest - icd-10 ----
test_get_release_latest_icd10 <- icd_get_releases("icd10", latest = TRUE)

testthat::expect_s3_class(test_get_release_latest_icd10, "tbl_df")
testthat::expect_type(test_get_release_latest_icd10, "list")


## Test get languages default ----
test_get_languages <- icd_get_languages()

testthat::expect_type(test_get_languages, "list")

## Test get languages NULL ----
test_get_languages <- icd_get_languages(icd = NULL)

testthat::expect_type(test_get_languages, "list")

## Test get languages icd10 ----
test_get_languages_icd10 <- icd_get_languages("icd10")

testthat::expect_type(test_get_languages_icd10, "list")

## Test get languages latest ----
test_get_languages_latest <- icd_get_languages(latest = TRUE)

testthat::expect_type(test_get_languages_latest, "list")

## Test get languages latest - icd10 ----
test_get_languages_latest_icd10 <- icd_get_languages("icd10", latest = TRUE)

testthat::expect_type(test_get_languages_latest_icd10, "list")

## Test icd_get_entities ----

testthat::expect_s3_class(icd_get_entities(), "tbl_df")
testthat::expect_s3_class(icd_get_entities(class = "block"), "tbl_df")
testthat::expect_s3_class(icd_get_entities(class = "test"), "tbl_df")
testthat::expect_equal(icd_get_entities(class = "test") |> nrow(), 0)
