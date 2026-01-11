///|
/// Stripe Webhooks
/// https://stripe.com/docs/webhooks
///
/// Webhook signature verification for secure event handling

///|
/// Stripe Event object (from webhook)
#external
pub type Event

///|
pub fn Event::as_any(self : Event) -> @core.Any = "%identity"

///|
/// Event ID
pub fn Event::id(self : Event) -> String {
  self.as_any()["id"].cast()
}

///|
/// Event type (e.g., "checkout.session.completed")
pub fn Event::event_type(self : Event) -> String {
  self.as_any()["type"].cast()
}

///|
/// Event data object
pub fn Event::data(self : Event) -> EventData {
  self.as_any()["data"].cast()
}

///|
/// Created timestamp (Unix)
pub fn Event::created(self : Event) -> Int {
  self.as_any()["created"].cast()
}

///|
/// API version used to render the event
pub fn Event::api_version(self : Event) -> String? {
  let v = self.as_any()["api_version"]
  if @core.is_nullish(v) {
    None
  } else {
    Some(v.cast())
  }
}

///|
/// Event data wrapper
#external
pub type EventData

///|
pub fn EventData::as_any(self : EventData) -> @core.Any = "%identity"

///|
/// The actual object (checkout session, subscription, etc.)
pub fn EventData::object(self : EventData) -> @core.Any {
  self.as_any()["object"]
}

///|
/// Previous attributes (for update events)
pub fn EventData::previous_attributes(self : EventData) -> @core.Any? {
  let v = self.as_any()["previous_attributes"]
  if @core.is_nullish(v) {
    None
  } else {
    Some(v)
  }
}

///|
/// Construct and verify a Stripe webhook event
extern "js" fn ffi_webhooks_construct_event(
  stripe : @core.Any,
  payload : String,
  signature : String,
  secret : String,
) -> @core.Any =
  #| (stripe, payload, sig, secret) => stripe.webhooks.constructEvent(payload, sig, secret)

///|
/// Construct and verify a Stripe webhook event (async version)
extern "js" fn ffi_webhooks_construct_event_async(
  stripe : @core.Any,
  payload : String,
  signature : String,
  secret : String,
) -> @js.Promise[@core.Any] =
  #| async (stripe, payload, sig, secret) => stripe.webhooks.constructEventAsync(payload, sig, secret)

///|
/// Webhook signature verification error
pub suberror WebhookSignatureVerificationError {
  WebhookSignatureVerificationError(String)
}

///|
/// Construct and verify a webhook event from raw payload
///
/// This is the synchronous version - use for most cases.
///
/// Example:
/// ```moonbit no-check
/// let event = stripe.webhooks_construct_event(
///   payload,
///   request.headers["stripe-signature"],
///   "whsec_xxx",
/// )
/// ```
pub fn Stripe::webhooks_construct_event(
  self : Stripe,
  payload : String,
  signature : String,
  endpoint_secret : String,
) -> Event raise WebhookSignatureVerificationError {
  // Note: constructEvent throws synchronously on invalid signature
  // We catch it and convert to our error type
  ffi_webhooks_construct_event(
    self.as_any(),
    payload,
    signature,
    endpoint_secret,
  ).cast()
}

///|
/// Construct and verify a webhook event (async version)
///
/// Use this for environments that require async crypto (e.g., Cloudflare Workers)
pub async fn Stripe::webhooks_construct_event_async(
  self : Stripe,
  payload : String,
  signature : String,
  endpoint_secret : String,
) -> Event raise WebhookSignatureVerificationError {
  ffi_webhooks_construct_event_async(
    self.as_any(),
    payload,
    signature,
    endpoint_secret,
  )
  .wait()
  .cast() catch {
    _ =>
      raise WebhookSignatureVerificationError::WebhookSignatureVerificationError(
        "Webhook signature verification failed",
      )
  }
}

///|
/// Common webhook event types
pub const EVENT_CHECKOUT_SESSION_COMPLETED : String = "checkout.session.completed"

///|
pub const EVENT_CHECKOUT_SESSION_EXPIRED : String = "checkout.session.expired"

///|
pub const EVENT_CUSTOMER_SUBSCRIPTION_CREATED : String = "customer.subscription.created"

///|
pub const EVENT_CUSTOMER_SUBSCRIPTION_UPDATED : String = "customer.subscription.updated"

///|
pub const EVENT_CUSTOMER_SUBSCRIPTION_DELETED : String = "customer.subscription.deleted"

///|
pub const EVENT_INVOICE_PAID : String = "invoice.paid"

///|
pub const EVENT_INVOICE_PAYMENT_FAILED : String = "invoice.payment_failed"

///|
pub const EVENT_PAYMENT_INTENT_SUCCEEDED : String = "payment_intent.succeeded"

///|
pub const EVENT_PAYMENT_INTENT_FAILED : String = "payment_intent.payment_failed"
