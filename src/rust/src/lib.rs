use extendr_api::prelude::*;
use tiktoken_rs::{
  bpe_for_model, bpe_for_tokenizer,
  tokenizer::{get_tokenizer, Tokenizer},
};

type RtResult<T> = std::result::Result<T, Error>;

// encodes text to tokens
#[extendr]
fn rs_get_tokens(text: &str, model: &str) -> RtResult<Vec<u32>> {
  // try to load the BPE from model (gpt-4o), otherwise from tokenizer (o200k-base)
  let bpe = match bpe_for_model(model) {
    Ok(bpe) => bpe,
    Err(_) => {
      let tokenizer = str_to_tokenizer(model)?;
      bpe_for_tokenizer(tokenizer).map_err(|e| {
        Error::Other(format!(
          "Failed to get BPE from tokenizer '{}': {}",
          model, e
        ))
      })?
    }
  };

  let tokens = bpe.encode_with_special_tokens(text);
  Ok(tokens)
}

#[extendr]
fn rs_get_token_count(text: &str, model: &str) -> RtResult<usize> {
  let tokens = rs_get_tokens(text, model)?;
  Ok(tokens.len())
}

// decodes tokens to text
#[extendr]
fn rs_decode_tokens(tokens: Vec<i32>, model: &str) -> RtResult<String> {
  let bpe = match bpe_for_model(model) {
    Ok(bpe) => bpe,
    Err(_) => {
      let tokenizer = str_to_tokenizer(model)?;
      bpe_for_tokenizer(tokenizer).map_err(|e| {
        Error::Other(format!(
          "Failed to get BPE from tokenizer '{}': {}",
          model, e
        ))
      })?
    }
  };

  let vec: Vec<u32> = tokens.into_iter().map(|x| x as u32).collect();
  bpe.decode(&vec)
    .map_err(|e| Error::Other(format!("Failed to decode tokens: {}", e)))
}

fn str_to_tokenizer(tokenizer: &str) -> RtResult<Tokenizer> {
  match tokenizer {
    "o200k_harmony" | "o200k-harmony" => Ok(Tokenizer::O200kHarmony),
    "o200k_base" | "o200k-base" => Ok(Tokenizer::O200kBase),
    "cl100k_base" | "cl100k-base" => Ok(Tokenizer::Cl100kBase),
    "p50k_base" | "p50k-base" => Ok(Tokenizer::P50kBase),
    "r50k_base" | "r50k-base" => Ok(Tokenizer::R50kBase),
    "p50k_edit" | "p50k-edit" => Ok(Tokenizer::P50kEdit),
    _ => get_tokenizer(tokenizer).ok_or_else(|| {
      Error::Other(format!(
        "Failed to get tokenizer from string '{}'",
        tokenizer
      ))
    }),
  }
}

// see https://github.com/zurawiki/tiktoken-rs/blob/main/tiktoken-rs/src/tokenizer.rs
fn tokenizer_to_str(tokenizer: Tokenizer) -> &'static str {
  match tokenizer {
    Tokenizer::O200kHarmony => "o200k_harmony",
    Tokenizer::O200kBase => "o200k_base",
    Tokenizer::Cl100kBase => "cl100k_base",
    Tokenizer::P50kBase => "p50k_base",
    Tokenizer::R50kBase => "r50k_base",
    Tokenizer::P50kEdit => "p50k_edit",
    Tokenizer::Gpt2 => "gpt2",
  }
}

// gets the name of the tokenizer for a given model
#[extendr]
fn rs_model_to_tokenizer(model: &str) -> RtResult<&'static str> {
  // note model-name != tokenizer-name, therefore this back and forth
  get_tokenizer(model)
    .map(tokenizer_to_str)
    .ok_or_else(|| Error::Other(format!("Could not find tokenizer for model '{}'", model)))
}

// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
  mod rtiktoken;
  fn rs_get_tokens;
  fn rs_model_to_tokenizer;
  fn rs_get_token_count;
  fn rs_decode_tokens;
}
