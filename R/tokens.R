#' Converts text to tokens
#'
#' @param text a character string to encode to tokens, can be a vector
#' @param model a model to use for tokenization, either a model name, eg `gpt-4o`
#' or a tokenizer, eg `o200k_base`.
#' See also [available tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).
#' @param verbose if `TRUE` print additional information, default `FALSE`
#'
#' @return a vector of tokens for the given text as integer
#' @export
#'
#' @seealso [model_to_tokenizer]()
#'
#' @examples
#' get_tokens("Hello World", "gpt-4o")
#' get_tokens("Hello World", "o200k_base")
#' get_tokens("Hello World", "clearly wrong")
get_tokens <- function(text, model, verbose = FALSE) {
  tok <- tryCatch(rs_model_to_tokenizer(model),
                  error = function(e) NULL)

  if (is.null(tok)) stop(sprintf("Unknown Model '%s'", model))
  if (verbose) cat(sprintf("Using Tokenizer '%s'\n", tok))

  if (length(text) > 1)
    return(lapply(text, function(x) get_tokens_internal(x, tok)))
  get_tokens_internal(text, tok)
}

get_tokens_internal <- function(text, tok) {
  res <- tryCatch(
    rs_get_tokens(text, tok),
    error = function(e) {
      stop(paste("Could not get tokens from text:", e))
    }
  )
  res
}
