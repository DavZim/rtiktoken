#' Decodes tokens back to text
#'
#' @param tokens a vector of tokens to decode, or a list of tokens
#' @param model a model to use for tokenization, either a model name, eg `gpt-4o`
#' or a tokenizer, eg `o200k_base`.
#' See also [available tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).
#' @param verbose if `TRUE` print additional information, default `FALSE`
#'
#' @return a character string of the decoded tokens or a vector or strings
#' @export
#'
#' @examples
#' tokens <- get_tokens("Hello World", "gpt-4o")
#' decode_tokens(tokens, "gpt-4o")
#'
#' tokens <- get_tokens(c("Hello World", "Alice Bob Charlie"), "gpt-4o")
#' decode_tokens(tokens, "gpt-4o")
decode_tokens <- function(tokens, model, verbose = FALSE) {
  tok <- tryCatch(rs_model_to_tokenizer(model),
                  error = function(e) NULL)
  if (is.null(tok)) stop(sprintf("Unknown Model '%s'", model))

  if (verbose) cat(sprintf("Using Tokenizer '%s'\n", tok))

  if (is.list(tokens)) {
    res <- sapply(tokens, function(x) decode_tokens_internal(as.integer(x), tok),
                  USE.NAMES = FALSE)
    return(res)
  }
  decode_tokens_internal(as.integer(tokens), tok)
}

decode_tokens_internal <- function(tokens, tok) {
  res <- tryCatch(
    rs_decode_tokens(tokens, tok),
    error = function(e) {
      stop(paste("Could not decode tokens:", e))
    }
  )
  res
}
