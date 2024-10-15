#' Gets the name of the tokenizer used by a model
#'
#' @param model the model to use, e.g., `gpt-4o`
#'
#' @return the tokenizer used by the model
#' @export
#'
#' @examples
#' model_to_tokenizer("gpt-4o")
#' model_to_tokenizer("gpt-4-1106-preview")
#' model_to_tokenizer("text-davinci-002")
#' model_to_tokenizer("text-embedding-ada-002")
#' model_to_tokenizer("text-embedding-3-small")
model_to_tokenizer <- function(model) {
  rs_model_to_tokenizer(model)
}
