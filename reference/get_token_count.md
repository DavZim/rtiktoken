# Returns the number of tokens in a text

Returns the number of tokens in a text

## Usage

``` r
get_token_count(text, model)
```

## Arguments

- text:

  a character string to encode to tokens, can be a vector

- model:

  a model to use for tokenization, either a model name, e.g., `gpt-4o`
  or a tokenizer, e.g., `o200k_base`. See also [available
  tokenizers](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs).

## Value

the number of tokens in the text, vector of integers

## See also

[`model_to_tokenizer()`](https://davzim.github.io/rtiktoken/reference/model_to_tokenizer.md),
[`get_tokens()`](https://davzim.github.io/rtiktoken/reference/get_tokens.md)

## Examples

``` r
get_token_count("Hello World", "gpt-4o")
#> [1] 2
get_token_count("Hello World", "gpt-5.3")
#> [1] 2
get_token_count("Hello World", "text-embedding-3-small")
#> [1] 2
```
