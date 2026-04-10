# Decodes tokens back to text

Decodes tokens back to text

## Usage

``` r
decode_tokens(tokens, model)
```

## Arguments

- tokens:

  a vector of tokens to decode, or a list of tokens

- model:

  a model to use for tokenization, either a model name, e.g., `gpt-4o`
  or a tokenizer, e.g., `o200k_base`. See also [available
  tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).

## Value

a character string of the decoded tokens or a vector or strings

## See also

[`model_to_tokenizer()`](https://davzim.github.io/rtiktoken/reference/model_to_tokenizer.md),
[`get_tokens()`](https://davzim.github.io/rtiktoken/reference/get_tokens.md)

## Examples

``` r
tokens <- get_tokens("Hello World", "gpt-4o")
tokens
#> [1] 13225  5922
decode_tokens(tokens, "gpt-4o")
#> [1] "Hello World"

tokens <- get_tokens(c("Hello World", "Alice Bob Charlie"), "gpt-4o")
tokens
#> [[1]]
#> [1] 13225  5922
#> 
#> [[2]]
#> [1] 100151  22582  41704
#> 
decode_tokens(tokens, "gpt-4o")
#> [1] "Hello World"       "Alice Bob Charlie"
```
