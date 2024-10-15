#' Decodes tokens back to text
#'
#' @param tokens a vector of tokens to decode, or a list of tokens
#' @param model a model to use for tokenization, either a model name, eg `gpt-4o`
#' or a tokenizer, eg `o200k_base`.
#' See also [available tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).
#'
#' @return a character string of the decoded tokens or a vector or strings
#' @export
#'
#' @seealso [model_to_tokenizer()], [get_tokens()]
#'
#' @examples
#' tokens <- get_tokens("Hello World", "gpt-4o")
#' tokens
#' decode_tokens(tokens, "gpt-4o")
#'
#' tokens <- get_tokens(c("Hello World", "Alice Bob Charlie"), "gpt-4o")
#' tokens
#' decode_tokens(tokens, "gpt-4o")
decode_tokens <- function(tokens, model) {
  if (is.list(tokens)) {
    sapply(tokens, function(x) decode_tokens_internal(as.integer(x), model),
           USE.NAMES = FALSE)
  } else {
    decode_tokens_internal(as.integer(tokens), model)
  }
}

decode_tokens_internal <- function(tokens, model) {
  res <- tryCatch(
    rs_decode_tokens(tokens, model),
    error = function(e) {
      stop(paste("Could not decode tokens:", e))
    }
  )
  res
}
