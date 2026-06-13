# Test search function/s -------------------------------------------------------

## Foundation ----

testthat::test_that(
  "icd_search_foundation() returns a tibble with the expected columns and types", {
    skip_if_no_icd_api()
    test_search_default <- icd_search_foundation(q = "cholera")
    testthat::expect_message(icd_search_foundation(q = "cholera"))
    testthat::expect_s3_class(test_search_default, "tbl_df")
    testthat::expect_type(test_search_default, "list")
  }
)

testthat::test_that(
  "icd_search_foundation() returns no message when verbose = FALSE", {
    skip_if_no_icd_api()
    testthat::expect_no_message(
      icd_search_foundation(q = "cholera", verbose = FALSE)
    )
  }
)

testthat::test_that(
  "icd_search_foundation() returns a list when tabular = FALSE", {
    skip_if_no_icd_api()
    test_search_list <- icd_search_foundation(q = "cholera", tabular = FALSE)
    testthat::expect_type(test_search_list, "list")
  }
)

testthat::test_that(
  "icd_search_foundation() returns a tibble with the expected columns and types for a specific release", {
    skip_if_no_icd_api()
    test_search_release <- icd_search_foundation(q = "cholera", release = "2024-01")
    testthat::expect_message(icd_search_foundation(q = "cholera", release = "2024-01"))
    testthat::expect_s3_class(test_search_release, "tbl_df")
    testthat::expect_type(test_search_release, "list")
  }
)

testthat::test_that(
  "icd_search_foundation() raises an error for an unavailable release", {
    skip_if_no_icd_api()
    testthat::expect_error(
      icd_search_foundation(q = "cholera", release = "2025-01")
    )
  }
)

testthat::test_that(
  "icd_search_foundation() raises a warning for an unavailable language", {
    skip_if_no_icd_api()
    testthat::expect_warning(
      icd_search_foundation(q = "cholera", language = "pp")
    )
  }
)


testthat::test_that(
  "icd_search_foundation() returns a tibble with the expected columns and types for a specific subtree", {
    skip_if_no_icd_api()
    test_search_subtree <- icd_search_foundation(q = "cholera", subtree = "http://id.who.int/icd/entity/1435254666")
    testthat::expect_message(icd_search_foundation(q = "cholera", subtree = "http://id.who.int/icd/entity/1435254666"))
    testthat::expect_s3_class(test_search_subtree, "tbl_df")
    testthat::expect_type(test_search_subtree, "list")
  }
)

testthat::test_that(
  "icd_search_release() returns expected output", {
    skip_if_no_icd_api()
    test_search_release <- icd_search_foundation(q = "cholera", release = "2024-01")
    testthat::expect_message(icd_search_foundation(q = "cholera", release = "2024-01"))
    testthat::expect_s3_class(test_search_release, "tbl_df")
    testthat::expect_type(test_search_release, "list")
    testthat::expect_error(icd_search_foundation(q = "cholera", release = "2025-01"))
  }
)

testthat::test_that(
  "icd_search_foundation() returns with the expected outputs when searching for a specific chapter", {
    skip_if_no_icd_api()
    test_search_chapter <- icd_search_foundation(q = "cholera", chapter = "01")
    testthat::expect_message(icd_search_foundation(q = "cholera", chapter = "01"))
    testthat::expect_s3_class(test_search_chapter, "tbl_df")
    testthat::expect_type(test_search_chapter, "list")
  }
)


### Test properties query ----

testthat::test_that(
  "icd_search_foundation() returns with the expected outputs when searching for specific properties", {
    skip_if_no_icd_api()
    test_search_property <- icd_search_foundation(
      q = "cholera",
      properties = c(
        "Title","Synonym", "NarrowerTerm", "FullySpecifiedName",
        "Definition", "Exclusion"
      )
    )
    testthat::expect_s3_class(test_search_property, "tbl_df")
    testthat::expect_type(test_search_property, "list")
  }
)

testthat::test_that(
  "icd_search_foundation() returns with the expected outputs when searching for specific properties in non-medical mode", {
    skip_if_no_icd_api()
    testthat::expect_s3_class(
      icd_search(
        q = "cholera",
        medical_mode = FALSE,
        properties = c("Title","Definition", "IndexTerm")
      ),
      "tbl_df"
    )
    testthat::expect_error(
      icd_search(
        q = "cholera",
        medical_mode = FALSE)
    )
  }
)

testthat::test_that(
  "icd_search_foundation() returns message or no message depending on verbose", {
    skip_if_no_icd_api()
    testthat::expect_message(icd_search_foundation(q = "cholera"))
    testthat::expect_no_message(
      icd_search_foundation(q = "cholera", verbose = FALSE)
    )
  }
)

testthat::test_that(
  "icd_search() returns a list when tabular = FALSE", {
    skip_if_no_icd_api()
    test_search_list <- icd_search(q = "cholera", tabular = FALSE)
    testthat::expect_type(test_search_list, "list")
  }
)

testthat::test_that(
  "icd_search() returns with the expected outputs when searching for a specific release", {
    skip_if_no_icd_api()
    test_search_release <- icd_search(q = "cholera", release = "2024-01")
    testthat::expect_message(icd_search(q = "cholera", release = "2024-01"))
    testthat::expect_s3_class(test_search_release, "tbl_df")
    testthat::expect_type(test_search_release, "list")
    testthat::expect_error(icd_search(q = "cholera", release = "2025-01"))
  }
)
  
testthat::test_that(
  "icd_search() raises a warning for an unavailable language", {
    skip_if_no_icd_api()
    testthat::expect_warning(icd_search(q = "cholera", language = "pp"))
  }
)

testthat::test_that(
  "icd_search() returns with the expected outputs when searching for specific properties in ICF linearization", {
    skip_if_no_icd_api()
    test_search_default <- icd_search(q = "cholera", linearization = "icf")
    testthat::expect_message(icd_search(q = "cholera", linearization = "icf"))
    testthat::expect_s3_class(test_search_default, "tbl_df")
    testthat::expect_type(test_search_default, "list")
  }
)

testthat::test_that(
  "icd_search() returns message or no message depending on verbose", {
    skip_if_no_icd_api()
    testthat::expect_message(icd_search(q = "cholera"))
    testthat::expect_no_message(
      icd_search(q = "cholera", verbose = FALSE)
    )
  }
)

testthat::test_that(
  "icd_search() returns a list when tabular = FALSE", {
    skip_if_no_icd_api()
    test_search_list <- icd_search(q = "cholera", tabular = FALSE)
    testthat::expect_type(test_search_list, "list")
  }
)

### Test release specification ----

testthat::test_that(
  "icd_search() returns with the expected outputs when searching for a specific release", {
    skip_if_no_icd_api()
    test_search_release <- icd_search(q = "cholera", release = "2024-01")
    testthat::expect_message(icd_search(q = "cholera", release = "2024-01"))
    testthat::expect_s3_class(test_search_release, "tbl_df")
    testthat::expect_type(test_search_release, "list")
    testthat::expect_error(icd_search(q = "cholera", release = "2025-01"))
  }
)
