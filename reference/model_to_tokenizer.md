# Gets the name of the tokenizer used by a model

Gets the name of the tokenizer used by a model

## Usage

``` r
model_to_tokenizer(model)
```

## Arguments

- model:

  the model to use, e.g., `gpt-4o`

## Value

the tokenizer used by the model

## Examples

``` r
model_to_tokenizer("gpt-4o")
#> [1] "o200k_base"
model_to_tokenizer("gpt-4-1106-preview")
#> [1] "cl100k_base"
model_to_tokenizer("text-davinci-002")
#> [1] "p50k_base"
model_to_tokenizer("text-embedding-ada-002")
#> [1] "cl100k_base"
model_to_tokenizer("text-embedding-3-small")
#> [1] "cl100k_base"
```
