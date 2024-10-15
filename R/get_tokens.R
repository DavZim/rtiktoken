#' Converts text to tokens
#'
#' @param text a character string to encode to tokens, can be a vector
#' @param model a model to use for tokenization, either a model name, eg `gpt-4o`
#' or a tokenizer, eg `o200k_base`.
#' See also [available tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).
#'
#' @return a vector of tokens for the given text as integer
#' @export
#'
#' @seealso [model_to_tokenizer()], [decode_tokens()]
#'
#' @examples
#' get_tokens("Hello World", "gpt-4o")
#' get_tokens("Hello World", "o200k_base")
get_tokens <- function(text, model) {
  if (length(text) > 1) {
    return(lapply(text, function(x) get_tokens_internal(x, model)))
  } else {
    get_tokens_internal(text, model)
  }
}

get_tokens_internal <- function(text, model) {
  res <- tryCatch(
    rs_get_tokens(text, model),
    error = function(e) {
      stop(paste("Could not get tokens from text:", e))
    }
  )
  res
}
