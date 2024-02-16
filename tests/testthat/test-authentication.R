# Test authentication functions ------------------------------------------------

## Create client ----
test_client <- icd_oauth_client()

## Test client ----
testthat::expect_s3_class(test_client, "httr2_oauth_client")
testthat::expect_type(test_client, "list")

## Create and authenticate a request ----
req <- httr2::request("https://id.who.int/icd/entity")
test_authenticate <- icd_authenticate(req, client = test_client)

## Test request authentication ----
testthat::expect_s3_class(test_authenticate, "httr2_request")
testthat::expect_type(test_authenticate, "list")

