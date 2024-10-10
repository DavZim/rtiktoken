test_that("model_to_tokenizer works", {
  expect_equal(model_to_tokenizer("gpt-4o"), "o200k_base")
  expect_equal(model_to_tokenizer("text-embedding-ada-002"), "cl100k_base")
  expect_error(model_to_tokenizer("wrong-model")) # TODO this prints the errors!
})

test_that("get_tokens works", {
  expect_equal(get_tokens("Hello World", "gpt-4o"), c(13225L, 5922L))
  expect_equal(get_tokens("Hello World", "gpt-3.5-turbo"), c(9906L, 4435L))
  expect_error(get_tokens("Hello World", "wrong-model"))


  expect_equal(get_tokens(c("Hello World", "Alice Bob"), "gpt-4o"),
               list(c(13225L, 5922L), c(100151L, 22582L)))
})

test_that("decode_tokens works", {
  expect_equal(decode_tokens(c(13225L, 5922L), "gpt-4o"), "Hello World")

  expect_equal(decode_tokens(get_tokens("Hello World 123", "gpt-4o"), "gpt-4o"),
               "Hello World 123")

  text <- c("Hello World 123", "Alice Bob")
  expect_equal(decode_tokens(get_tokens(text, "gpt-4o"), "gpt-4o"),
               text)
})

test_that("get_token_count works", {
  expect_equal(get_token_count("Hello World", "gpt-4o"), 2)
  expect_equal(get_token_count("Hello World 123", "gpt-4o"), 4)

  expect_equal(get_token_count(c("Hello World", "Alice Bob"), "gpt-4o"),
               c(2, 2))
})
