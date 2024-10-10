use extendr_api::prelude::*;
use tiktoken_rs::{
  get_bpe_from_model,
  get_bpe_from_tokenizer,
  tokenizer::{
    get_tokenizer,
    Tokenizer,
  }
};

// encodes text to tokens
#[extendr]
fn rs_get_tokens(text: &str, model: &str) -> Vec<usize> {
    // try to load the BPE from model (gpt-4o),
    // otherwise from tokenizer (o200k-base)
    let bpe = match get_bpe_from_model(model) {
        Ok(bpe) => bpe,
        Err(_) => {
          get_bpe_from_tokenizer(str_to_tokenizer(model))
            .expect("Failed to get BPE from tokenizer")
        },
    };

    let tokens = bpe.encode_with_special_tokens(text);
    tokens
}

#[extendr]
fn rs_get_token_count(text: &str, model: &str) -> usize {
  let tokens = rs_get_tokens(text, model);
  tokens.len()
}

// decodes tokens to text
#[extendr]
fn rs_decode_tokens(tokens: Vec<i32>, model: &str) -> String {
  let bpe = match get_bpe_from_model(model) {
    Ok(bpe) => bpe,
    Err(_) => {
      get_bpe_from_tokenizer(str_to_tokenizer(model))
        .expect("Failed to get BPE from tokenizer")
    },
  };

  let vec_usize: Vec<usize> = tokens.into_iter().map(|x| x as usize).collect();
  bpe.decode(vec_usize.clone()).unwrap()
}



fn str_to_tokenizer(tokenizer: &str) -> Tokenizer {
    match tokenizer {
        "o200k_base" => Tokenizer::O200kBase,
        "cl100k_base" => Tokenizer::Cl100kBase,
        "p50k_base" => Tokenizer::P50kBase,
        "r50k_base" => Tokenizer::R50kBase,
        "p50k_edit" => Tokenizer::P50kEdit,
        "gpt2" => Tokenizer::Gpt2,
        _ => panic!("Failed to get tokenizer from string '{}'", tokenizer),
    }
}
fn tokenizer_to_str(tokenizer: Tokenizer) -> &'static str {
    match tokenizer {
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
fn rs_model_to_tokenizer(model: &str) -> &'static str {
  return tokenizer_to_str(
    get_tokenizer(model)
      .expect(&format!("Could not find tokenizer for model '{}'", model))
  );
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
