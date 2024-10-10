#' Returns the number of tokens in a text
#'
#' @param text a character string to encode to tokens, can be a vector
#' @param model a model to use for tokenization, either a model name, eg `gpt-4o`
#' or a tokenizer, eg `o200k_base`.
#' See also [available tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).
#'
#' @return the number of tokens in the text, vector of ints
#' @export
#'
#' @seealso [model_to_tokenizer]()
#' @export
#'
#' @examples
#' get_token_count("Hello World", "gpt-4o")
get_token_count <- function(text, model) {
  tok <- rs_model_to_tokenizer(model)
  if (length(text) > 1) {
    res <- sapply(text, function(x) rs_get_token_count(x, tok),
                  USE.NAMES = FALSE)
    return(res)
  }
  rs_get_token_count(text, tok)
}
