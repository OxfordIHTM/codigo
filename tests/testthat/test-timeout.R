# Tests for retry and timeout features -----------------------------------------

testthat::test_that("icd_req_policies sets timeout and retry defaults", {
  req <- httr2::request("https://id.who.int") |> icd_req_policies()

  testthat::expect_equal(req$options$timeout_ms, 30000)   # 30s default
  testthat::expect_equal(req$policies$retry_max_tries, 5)
  testthat::expect_true(req$policies$retry_on_failure)
})

testthat::test_that("icd_req_policies honours custom timeout and max_tries", {
  req <- httr2::request("https://id.who.int") |>
    icd_req_policies(timeout = 12, max_tries = 4)

  testthat::expect_equal(req$options$timeout_ms, 12000)
  testthat::expect_equal(req$policies$retry_max_tries, 4)
})

testthat::test_that("only transient statuses are retried", {
  req <- httr2::request("https://id.who.int") |> icd_req_policies()
  is_transient <- req$policies$retry_is_transient

  testthat::expect_true(is_transient(httr2::response(429)))
  testthat::expect_true(is_transient(httr2::response(500)))
  testthat::expect_true(is_transient(httr2::response(503)))
  testthat::expect_false(is_transient(httr2::response(404)))
  testthat::expect_false(is_transient(httr2::response(200)))
})

testthat::skip_if_not_installed("webfakes")

testthat::test_that("transient errors are retried until success", {
  app <- webfakes::new_app()
  app$locals$n <- 0L
  app$get("/flaky", function(req, res) {
    res$app$locals$n <- res$app$locals$n + 1L
    n <- res$app$locals$n
    if (n < 3L) {
      res$set_header("Retry-After", "0")$ # makes retries immediate
        set_status(503L)$send_json(list(attempt = n), auto_unbox = TRUE)
    } else {
      res$set_status(200L)$send_json(list(attempt = n), auto_unbox = TRUE)
    }
  })
  server <- webfakes::local_app_process(app)

  resp <- httr2::request(server$url("/flaky")) |>
    icd_req_policies(max_tries = 3) |>
    httr2::req_perform()

  testthat::expect_equal(httr2::resp_status(resp), 200)
  testthat::expect_equal(httr2::resp_body_json(resp)$attempt, 3)
})

testthat::test_that("a permanent error is not retried", {
  app <- webfakes::new_app()
  app$locals$n <- 0L
  app$get("/nope", function(req, res) {
    res$app$locals$n <- res$app$locals$n + 1L
    res$set_status(404L)$send_json(list(attempt = res$app$locals$n), auto_unbox = TRUE)
  })
  server <- webfakes::local_app_process(app)

  resp <- httr2::request(server$url("/nope")) |>
    icd_req_policies(max_tries = 3) |>
    httr2::req_error(is_error = \(resp) FALSE) |>
    httr2::req_perform()

  # 404 is not transient -> exactly one attempt, no retries
  testthat::expect_equal(httr2::resp_status(resp), 404)
  testthat::expect_equal(httr2::resp_body_json(resp)$attempt, 1)
})


testthat::test_that("a request aborts when it exceeds the timeout", {
  app <- webfakes::new_app()
  app$get("/slow", function(req, res) {
    Sys.sleep(2)
    res$set_status(200L)$send_json(list(ok = TRUE), auto_unbox = TRUE)
  })
  server <- webfakes::local_app_process(app)

  testthat::expect_error(
    httr2::request(server$url("/slow")) |>
      icd_req_policies(timeout = 1, max_tries = 1) |>
      httr2::req_perform(),
    class = "httr2_failure"
  )
})
