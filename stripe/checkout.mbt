///|
/// Stripe Checkout Sessions API
/// https://stripe.com/docs/api/checkout/sessions

///|
/// Checkout Session object
#external
pub type CheckoutSession

///|
pub fn CheckoutSession::as_any(self : CheckoutSession) -> @core.Any = "%identity"

///|
/// Get session ID
pub fn CheckoutSession::id(self : CheckoutSession) -> String {
  self.as_any()["id"].cast()
}

///|
/// Get session URL (for redirecting customer)
pub fn CheckoutSession::url(self : CheckoutSession) -> String? {
  let url = self.as_any()["url"]
  if @core.is_nullish(url) {
    None
  } else {
    Some(url.cast())
  }
}

///|
/// Get customer ID
pub fn CheckoutSession::customer(self : CheckoutSession) -> String? {
  let customer = self.as_any()["customer"]
  if @core.is_nullish(customer) {
    None
  } else {
    Some(customer.cast())
  }
}

///|
/// Get customer email
pub fn CheckoutSession::customer_email(self : CheckoutSession) -> String? {
  let email = self.as_any()["customer_email"]
  if @core.is_nullish(email) {
    None
  } else {
    Some(email.cast())
  }
}

///|
/// Get customer details
pub fn CheckoutSession::customer_details(
  self : CheckoutSession,
) -> CustomerDetails? {
  let details = self.as_any()["customer_details"]
  if @core.is_nullish(details) {
    None
  } else {
    Some(details.cast())
  }
}

///|
/// Get subscription ID
pub fn CheckoutSession::subscription(self : CheckoutSession) -> String? {
  let sub = self.as_any()["subscription"]
  if @core.is_nullish(sub) {
    None
  } else {
    Some(sub.cast())
  }
}

///|
/// Get payment status
pub fn CheckoutSession::payment_status(self : CheckoutSession) -> String {
  self.as_any()["payment_status"].cast()
}

///|
/// Get session status
pub fn CheckoutSession::status(self : CheckoutSession) -> String {
  self.as_any()["status"].cast()
}

///|
/// Customer details from checkout session
#external
pub type CustomerDetails

///|
pub fn CustomerDetails::as_any(self : CustomerDetails) -> @core.Any = "%identity"

///|
pub fn CustomerDetails::email(self : CustomerDetails) -> String? {
  let email = self.as_any()["email"]
  if @core.is_nullish(email) {
    None
  } else {
    Some(email.cast())
  }
}

///|
pub fn CustomerDetails::name(self : CustomerDetails) -> String? {
  let name = self.as_any()["name"]
  if @core.is_nullish(name) {
    None
  } else {
    Some(name.cast())
  }
}

///|
/// Checkout Session mode
pub(all) enum CheckoutMode {
  Payment
  Setup
  Subscription
}

///|
pub fn checkout_mode_to_string(mode : CheckoutMode) -> String {
  match mode {
    Payment => "payment"
    Setup => "setup"
    Subscription => "subscription"
  }
}

///|
/// Line item for checkout session
pub(all) struct LineItem {
  price : String
  quantity : Int
}

///|
/// Checkout session creation parameters
pub(all) struct CheckoutSessionCreateParams {
  mode : CheckoutMode
  line_items : Array[LineItem]
  success_url : String
  cancel_url : String
  customer_email : String?
  client_reference_id : String?
  metadata : Map[String, String]?
}

///|
pub fn checkout_params_to_any(
  params : CheckoutSessionCreateParams,
) -> @core.Any {
  let obj = @core.new_object()
  obj["mode"] = @core.any(checkout_mode_to_string(params.mode))
  obj["success_url"] = @core.any(params.success_url)
  obj["cancel_url"] = @core.any(params.cancel_url)

  // line_items
  let items = @core.new_array()
  for item in params.line_items {
    let item_obj = @core.new_object()
    item_obj["price"] = @core.any(item.price)
    item_obj["quantity"] = @core.any(item.quantity)
    items._call("push", [@core.any(item_obj)]) |> ignore
  }
  obj["line_items"] = items
  if params.customer_email is Some(v) {
    obj["customer_email"] = @core.any(v)
  }
  if params.client_reference_id is Some(v) {
    obj["client_reference_id"] = @core.any(v)
  }
  if params.metadata is Some(m) {
    let meta = @core.new_object()
    for k, v in m {
      meta[k] = @core.any(v)
    }
    obj["metadata"] = meta
  }
  obj
}

///|
/// Create a checkout session
extern "js" fn ffi_checkout_sessions_create(
  stripe : @core.Any,
  params : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (stripe, params) => stripe.checkout.sessions.create(params)

///|
/// Retrieve a checkout session
extern "js" fn ffi_checkout_sessions_retrieve(
  stripe : @core.Any,
  session_id : String,
) -> @js.Promise[@core.Any] =
  #| (stripe, sessionId) => stripe.checkout.sessions.retrieve(sessionId)

///|
/// Create a new Checkout Session
///
/// Example:
/// ```moonbit no-check
/// let session = stripe.checkout_sessions_create({
///   mode: Subscription,
///   line_items: [{ price: "price_xxx", quantity: 1 }],
///   success_url: "https://example.com/success?session_id={CHECKOUT_SESSION_ID}",
///   cancel_url: "https://example.com/cancel",
/// })
/// ```
pub async fn Stripe::checkout_sessions_create(
  self : Stripe,
  params : CheckoutSessionCreateParams,
) -> CheckoutSession {
  ffi_checkout_sessions_create(self.as_any(), checkout_params_to_any(params))
  .wait()
  .cast()
}

///|
/// Retrieve a Checkout Session by ID
pub async fn Stripe::checkout_sessions_retrieve(
  self : Stripe,
  session_id : String,
) -> CheckoutSession {
  ffi_checkout_sessions_retrieve(self.as_any(), session_id).wait().cast()
}
