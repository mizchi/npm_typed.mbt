///|
/// Stripe Subscriptions API
/// https://stripe.com/docs/api/subscriptions

///|
/// Subscription object
#external
pub type Subscription

///|
pub fn Subscription::as_any(self : Subscription) -> @core.Any = "%identity"

///|
pub fn Subscription::id(self : Subscription) -> String {
  self.as_any()["id"].cast()
}

///|
pub fn Subscription::customer(self : Subscription) -> String {
  self.as_any()["customer"].cast()
}

///|
pub fn Subscription::status(self : Subscription) -> String {
  self.as_any()["status"].cast()
}

///|
pub fn Subscription::current_period_start(self : Subscription) -> Int {
  self.as_any()["current_period_start"].cast()
}

///|
pub fn Subscription::current_period_end(self : Subscription) -> Int {
  self.as_any()["current_period_end"].cast()
}

///|
pub fn Subscription::cancel_at_period_end(self : Subscription) -> Bool {
  self.as_any()["cancel_at_period_end"].cast()
}

///|
pub fn Subscription::canceled_at(self : Subscription) -> Int? {
  let v = self.as_any()["canceled_at"]
  if @core.is_nullish(v) {
    None
  } else {
    Some(v.cast())
  }
}

///|
/// Subscription item for creation
pub(all) struct SubscriptionItem {
  price : String
  quantity : Int?
}

///|
/// Subscription creation parameters
pub(all) struct SubscriptionCreateParams {
  customer : String
  items : Array[SubscriptionItem]
  payment_behavior : String?
  default_payment_method : String?
  metadata : Map[String, String]?
}

///|
pub fn subscription_create_params_to_any(
  params : SubscriptionCreateParams,
) -> @core.Any {
  let obj = @core.new_object()
  obj["customer"] = @core.any(params.customer)
  let items = @core.new_array()
  for item in params.items {
    let item_obj = @core.new_object()
    item_obj["price"] = @core.any(item.price)
    if item.quantity is Some(q) {
      item_obj["quantity"] = @core.any(q)
    }
    items._call("push", [@core.any(item_obj)]) |> ignore
  }
  obj["items"] = items
  if params.payment_behavior is Some(v) {
    obj["payment_behavior"] = @core.any(v)
  }
  if params.default_payment_method is Some(v) {
    obj["default_payment_method"] = @core.any(v)
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
/// Subscription update parameters
pub(all) struct SubscriptionUpdateParams {
  cancel_at_period_end : Bool?
  default_payment_method : String?
  metadata : Map[String, String]?
}

///|
fn subscription_update_params_to_any(
  params : SubscriptionUpdateParams,
) -> @core.Any {
  let obj = @core.new_object()
  if params.cancel_at_period_end is Some(v) {
    obj["cancel_at_period_end"] = @core.any(v)
  }
  if params.default_payment_method is Some(v) {
    obj["default_payment_method"] = @core.any(v)
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
extern "js" fn ffi_subscriptions_create(
  stripe : @core.Any,
  params : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (stripe, params) => stripe.subscriptions.create(params)

///|
extern "js" fn ffi_subscriptions_retrieve(
  stripe : @core.Any,
  subscription_id : String,
) -> @js.Promise[@core.Any] =
  #| (stripe, subId) => stripe.subscriptions.retrieve(subId)

///|
extern "js" fn ffi_subscriptions_update(
  stripe : @core.Any,
  subscription_id : String,
  params : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (stripe, subId, params) => stripe.subscriptions.update(subId, params)

///|
extern "js" fn ffi_subscriptions_cancel(
  stripe : @core.Any,
  subscription_id : String,
) -> @js.Promise[@core.Any] =
  #| (stripe, subId) => stripe.subscriptions.cancel(subId)

///|
/// Create a subscription
pub async fn Stripe::subscriptions_create(
  self : Stripe,
  params : SubscriptionCreateParams,
) -> Subscription {
  ffi_subscriptions_create(
    self.as_any(),
    subscription_create_params_to_any(params),
  )
  .wait()
  .cast()
}

///|
/// Retrieve a subscription by ID
pub async fn Stripe::subscriptions_retrieve(
  self : Stripe,
  subscription_id : String,
) -> Subscription {
  ffi_subscriptions_retrieve(self.as_any(), subscription_id).wait().cast()
}

///|
/// Update a subscription
pub async fn Stripe::subscriptions_update(
  self : Stripe,
  subscription_id : String,
  params : SubscriptionUpdateParams,
) -> Subscription {
  ffi_subscriptions_update(
    self.as_any(),
    subscription_id,
    subscription_update_params_to_any(params),
  )
  .wait()
  .cast()
}

///|
/// Cancel a subscription
pub async fn Stripe::subscriptions_cancel(
  self : Stripe,
  subscription_id : String,
) -> Subscription {
  ffi_subscriptions_cancel(self.as_any(), subscription_id).wait().cast()
}
