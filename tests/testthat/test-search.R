# Test search function/s -------------------------------------------------------

## Foundation ----

test_search_default <- icd_search_foundation(q = "cholera")

### Test message ----
testthat::expect_message(icd_search_foundation(q = "cholera"))
testthat::expect_s3_class(test_search_default, "tbl_df")
testthat::expect_type(test_search_default, "list")

### Test no message ----
testthat::expect_no_message(icd_search_foundation(q = "cholera", verbose = FALSE))

### Test list output ----
test_search_list <- icd_search_foundation(q = "cholera", tabular = FALSE)

testthat::expect_type(test_search_list, "list")

### Test release specification ----
test_search_release <- icd_search_foundation(q = "cholera", release = "2024-01")
testthat::expect_message(icd_search_foundation(q = "cholera", release = "2024-01"))
testthat::expect_s3_class(test_search_release, "tbl_df")
testthat::expect_type(test_search_release, "list")
testthat::expect_error(icd_search_foundation(q = "cholera", release = "2025-01"))

### Test language specification ----
testthat::expect_warning(icd_search_foundation(q = "cholera", language = "pp"))

### Test subtrees query ----
test_search_subtree <- icd_search_foundation(q = "cholera", subtree = "http://id.who.int/icd/entity/1435254666")
testthat::expect_message(icd_search_foundation(q = "cholera", subtree = "http://id.who.int/icd/entity/1435254666"))
testthat::expect_s3_class(test_search_subtree, "tbl_df")
testthat::expect_type(test_search_subtree, "list")

### Test chapter query ----
test_search_chapter <- icd_search_foundation(q = "cholera", chapter = "01")
testthat::expect_message(icd_search_foundation(q = "cholera", chapter = "01"))
testthat::expect_s3_class(test_search_chapter, "tbl_df")
testthat::expect_type(test_search_chapter, "list")

### Test properties query ----
test_search_property <- icd_search_foundation(
  q = "cholera",
  properties = c(
    "Title","Synonym", "NarrowerTerm", "FullySpecifiedName",
    "Definition", "Exclusion"
  )
)
testthat::expect_s3_class(test_search_property, "tbl_df")
testthat::expect_type(test_search_property, "list")


## Linearization - MMS ----

test_search_default <- icd_search(q = "cholera")

### Test message ----
testthat::expect_message(icd_search(q = "cholera"))
testthat::expect_s3_class(test_search_default, "tbl_df")
testthat::expect_type(test_search_default, "list")

### Test no message ----
testthat::expect_no_message(icd_search(q = "cholera", verbose = FALSE))

### Test list output ----
test_search_list <- icd_search(q = "cholera", tabular = FALSE)

testthat::expect_type(test_search_list, "list")

### Test release specification ----
test_search_release <- icd_search(q = "cholera", release = "2024-01")
testthat::expect_message(icd_search(q = "cholera", release = "2024-01"))
testthat::expect_s3_class(test_search_release, "tbl_df")
testthat::expect_type(test_search_release, "list")
testthat::expect_error(icd_search(q = "cholera", release = "2025-01"))

### Test language specification ----
testthat::expect_warning(icd_search(q = "cholera", language = "pp"))

### Test subtrees query ----
test_search_subtree <- icd_search(q = "cholera", subtree = "http://id.who.int/icd/entity/1435254666")
testthat::expect_message(icd_search(q = "cholera", subtree = "http://id.who.int/icd/entity/1435254666"))
testthat::expect_s3_class(test_search_subtree, "tbl_df")
testthat::expect_type(test_search_subtree, "list")

### Test chapter query ----
test_search_chapter <- icd_search(q = "cholera", chapter = "01")
testthat::expect_message(icd_search(q = "cholera", chapter = "01"))
testthat::expect_s3_class(test_search_chapter, "tbl_df")
testthat::expect_type(test_search_chapter, "list")

### Test properties query ----
test_search_property <- icd_search(
  q = "cholera",
  properties = c(
    "Title","Synonym", "NarrowerTerm", "FullySpecifiedName",
    "Definition", "Exclusion"
  )
)
testthat::expect_s3_class(test_search_property, "tbl_df")
testthat::expect_type(test_search_property, "list")

### Test medical_mode ----

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


## Linearization - ICF ----

test_search_default <- icd_search(q = "cholera", linearization = "icf")

### Test message ----
testthat::expect_message(icd_search(q = "cholera", linearization = "icf"))
testthat::expect_s3_class(test_search_default, "tbl_df")
testthat::expect_type(test_search_default, "list")

### Test no message ----
testthat::expect_no_message(
  icd_search(q = "cholera", linearization = "icf", verbose = FALSE)
)

### Test list output ----
test_search_list <- icd_search(
  q = "cholera",
  linearization = "icf",
  tabular = FALSE
)

testthat::expect_type(test_search_list, "list")

### Test release specification ----
test_search_release <- icd_search(
  q = "cholera", linearization = "icf", release = "2024-01"
)
testthat::expect_message(
  icd_search(
    q = "cholera", linearization = "icf", release = "2024-01"
  )
)
testthat::expect_s3_class(test_search_release, "tbl_df")
testthat::expect_type(test_search_release, "list")
testthat::expect_error(
  icd_search(q = "cholera", linearization = "icf", release = "2025-01")
)
