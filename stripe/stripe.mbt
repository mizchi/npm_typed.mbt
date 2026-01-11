///|
/// Stripe - Payment processing for the internet
/// https://stripe.com/docs/api
///
/// MoonBit FFI bindings for Stripe Node.js SDK

///|
/// Stripe client instance
#external
pub type Stripe

///|
pub fn Stripe::as_any(self : Stripe) -> @core.Any = "%identity"

///|
/// Stripe configuration options
pub(all) struct StripeConfig {
  api_version : String?
  max_network_retries : Int?
  timeout : Int?
}

///|
pub fn stripe_config_to_any(config : StripeConfig) -> @core.Any {
  let obj = @core.new_object()
  if config.api_version is Some(v) {
    obj["apiVersion"] = @core.any(v)
  }
  if config.max_network_retries is Some(v) {
    obj["maxNetworkRetries"] = @core.any(v)
  }
  if config.timeout is Some(v) {
    obj["timeout"] = @core.any(v)
  }
  obj
}

///|
/// Create a new Stripe client (async)
extern "js" fn ffi_new_stripe(api_key : String) -> @js.Promise[@core.Any] =
  #| (apiKey) => import("stripe").then(m => new m.default(apiKey))

///|
/// Create a new Stripe client with config (async)
extern "js" fn ffi_new_stripe_with_config(
  api_key : String,
  config : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (apiKey, config) => import("stripe").then(m => new m.default(apiKey, config))

///|
/// Create a new Stripe client
///
/// Example:
/// ```moonbit no-check
/// let stripe = Stripe::new("sk_test_xxx")
///
/// let stripe_with_config = Stripe::new("sk_test_xxx", config={
///   api_version: Some("2024-12-18"),
/// })
/// ```
pub async fn Stripe::new(api_key : String, config? : StripeConfig) -> Stripe {
  match config {
    Some(c) =>
      ffi_new_stripe_with_config(api_key, stripe_config_to_any(c)).wait().cast()
    None => ffi_new_stripe(api_key).wait().cast()
  }
}
