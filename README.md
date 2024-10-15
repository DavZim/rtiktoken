
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rtiktoken

<!-- badges: start -->
[![R-CMD-check](https://github.com/DavZim/rtiktoken/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/DavZim/rtiktoken/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/rtiktoken)](https://CRAN.R-project.org/package=rtiktoken)
<!-- badges: end -->

`{rtiktoken}` is a thin wrapper around
[`tiktoken-rs`](https://github.com/zurawiki/tiktoken-rs) (and in turn
around [OpenAI’s Python library
`tiktoken`](https://github.com/openai/tiktoken)). It provides functions
to encode text into tokens used by OpenAI’s models and decode tokens
back into text using
[BPE](https://en.wikipedia.org/wiki/Byte_pair_encoding) tokenizers. It
is also useful to count the numbers of tokens in a text to guess how
expensive a call to OpenAI’s API would be. Note that all the
tokenization happens offline and no internet connection is required.

Another use-case is to compute similarity scores between texts using
tokens.

Other use-cases can be found in the OpenAI’s cookbook [How to Count
Tokens with
`tiktoken`](https://github.com/openai/openai-cookbook/blob/main/examples/How_to_count_tokens_with_tiktoken.ipynb).

To verify the outputs of the functions, see also [OpenAI’s Tokenizer
Platform](https://platform.openai.com/tokenizer).

## Installation

You can install `rtiktoken` like so:

``` r
# Dev version
# install.packages("devtools")
# devtools::install_github("DavZim/rtiktoken")

# CRAN version
install.packages("rtiktoken")
```

## Example

``` r
library(rtiktoken)

# 1. Encode text into tokens
text <- c(
  "Hello World, this is a text that we are going to use in rtiktoken!",
  "Note that the functions are vectorized! Yay!"
)
tokens <- get_tokens(text, "gpt-4o")
tokens
#> [[1]]
#>  [1] 13225  5922    11   495   382   261  2201   484   581   553  2966   316
#> [13]  1199   306 38742  8251  2488     0
#> 
#> [[2]]
#>  [1]  12038    484    290   9964    553   9727   2110      0 115915      0

# 2. Decode tokens back into text
decoded_text <- decode_tokens(tokens, "gpt-4o")
decoded_text
#> [1] "Hello World, this is a text that we are going to use in rtiktoken!"
#> [2] "Note that the functions are vectorized! Yay!"

# Note that it's not guaranteed to produce the identical text as text-parts
# might be dropped if no token match is found.
identical(text, decoded_text)
#> [1] TRUE

# 3. Count the number of tokens in a text
n_tokens <- get_token_count(text, "gpt-4o")
n_tokens
#> [1] 18 10
```

### Models & Tokenizers

The different OpenAI models use different tokenizers (see also [source
code of
`tikoken-rs`](https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs)
for a full list).

The following models use the following tokenizers (note that all
functions of this package both allow to use the model names as well as
the tokenizer names):

| Model Name                                                             | Tokenizer Name        |
|------------------------------------------------------------------------|-----------------------|
| GPT-4o models                                                          | `o200k_base`          |
| ChatGPT models, eg `text-embedding-ada-002`, `gpt-3.5-turbo`, `gpt-4-` | `cl100k_base`         |
| Code models, eg `text-davinci-002`, `text-davinci-003`                 | `p50k_base`           |
| Edit models, eg `text-davinci-edit-001`, `code-davinci-edit-001`       | `p50k_edit`           |
| GPT-3 models, eg `davinci`                                             | `r50k_base` or `gpt2` |

## Development

`rtiktoken` is built using `extendr` and `Rust`. To build the package,
you need to have `Rust` installed on your machine.

``` r
rextendr::document()
devtools::document()
```
