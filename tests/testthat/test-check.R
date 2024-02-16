# Test check functions ---------------------------------------------------------

## Check single non-available language ----
testthat::expect_warning(icd_check_language(language = "pp"))

## Check multiple with some available language ----
testthat::expect_message(icd_check_language(language = c("zh", "fr", "pp")))
testthat::expect_equal(icd_check_language(language = c("zh", "fr", "pp")), c("zh", "fr"))

## Check multiple non-available languages ----
testthat::expect_warning(icd_check_language(language = c("aa", "bb", "pp")))
