#' Returns the number of tokens in a text
#'
#' @param text a character string to encode to tokens, can be a vector
#' @param model a model to use for tokenization, either a model name, e.g., `gpt-4o`
#' or a tokenizer, e.g., `o200k_base`.
#' See also [available tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).
#'
#' @return the number of tokens in the text, vector of integers
#' @export
#'
#' @seealso [model_to_tokenizer()], [get_tokens()]
#' @export
#'
#' @examples
#' get_token_count("Hello World", "gpt-4o")
get_token_count <- function(text, model) {
  if (length(text) > 1) {
    sapply(text, function(x) rs_get_token_count(x, model),
                  USE.NAMES = FALSE)
  } else {
    rs_get_token_count(text, model)
  }
}
