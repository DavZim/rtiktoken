# Converts text to tokens

Converts text to tokens

## Usage

``` r
get_tokens(text, model)
```

## Arguments

- text:

  a character string to encode to tokens, can be a vector

- model:

  a model to use for tokenization, either a model name, e.g., `gpt-4o`
  or a tokenizer, e.g., `o200k_base`. See also [available
  tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).

## Value

a vector of tokens for the given text as integer

## See also

[`model_to_tokenizer()`](https://davzim.github.io/rtiktoken/reference/model_to_tokenizer.md),
[`decode_tokens()`](https://davzim.github.io/rtiktoken/reference/decode_tokens.md)

## Examples

``` r
get_tokens("Hello World", "gpt-4o")
#> [1] 13225  5922
get_tokens("Hello World", "o200k_base")
#> [1] 13225  5922
get_tokens("Hello World", "gpt-5.")
#> [1] 13225  5922
get_tokens("Hello World", "text-embedding-3-small")
#> [1] 9906 4435
```
