///|
/// Stripe Customers API
/// https://stripe.com/docs/api/customers

///|
/// Customer object
#external
pub type Customer

///|
pub fn Customer::as_any(self : Customer) -> @core.Any = "%identity"

///|
pub fn Customer::id(self : Customer) -> String {
  self.as_any()["id"].cast()
}

///|
pub fn Customer::email(self : Customer) -> String? {
  let email = self.as_any()["email"]
  if @core.is_nullish(email) {
    None
  } else {
    Some(email.cast())
  }
}

///|
pub fn Customer::name(self : Customer) -> String? {
  let name = self.as_any()["name"]
  if @core.is_nullish(name) {
    None
  } else {
    Some(name.cast())
  }
}

///|
pub fn Customer::created(self : Customer) -> Int {
  self.as_any()["created"].cast()
}

///|
/// Customer creation parameters
pub(all) struct CustomerCreateParams {
  email : String?
  name : String?
  description : String?
  metadata : Map[String, String]?
}

///|
pub fn customer_create_params_to_any(
  params : CustomerCreateParams,
) -> @core.Any {
  let obj = @core.new_object()
  if params.email is Some(v) {
    obj["email"] = @core.any(v)
  }
  if params.name is Some(v) {
    obj["name"] = @core.any(v)
  }
  if params.description is Some(v) {
    obj["description"] = @core.any(v)
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
extern "js" fn ffi_customers_create(
  stripe : @core.Any,
  params : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (stripe, params) => stripe.customers.create(params)

///|
extern "js" fn ffi_customers_retrieve(
  stripe : @core.Any,
  customer_id : String,
) -> @js.Promise[@core.Any] =
  #| (stripe, customerId) => stripe.customers.retrieve(customerId)

///|
extern "js" fn ffi_customers_update(
  stripe : @core.Any,
  customer_id : String,
  params : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (stripe, customerId, params) => stripe.customers.update(customerId, params)

///|
extern "js" fn ffi_customers_del(
  stripe : @core.Any,
  customer_id : String,
) -> @js.Promise[@core.Any] =
  #| (stripe, customerId) => stripe.customers.del(customerId)

///|
/// Create a new customer
pub async fn Stripe::customers_create(
  self : Stripe,
  params : CustomerCreateParams,
) -> Customer {
  ffi_customers_create(self.as_any(), customer_create_params_to_any(params))
  .wait()
  .cast()
}

///|
/// Retrieve a customer by ID
pub async fn Stripe::customers_retrieve(
  self : Stripe,
  customer_id : String,
) -> Customer {
  ffi_customers_retrieve(self.as_any(), customer_id).wait().cast()
}

///|
/// Update a customer
pub async fn Stripe::customers_update(
  self : Stripe,
  customer_id : String,
  params : CustomerCreateParams,
) -> Customer {
  ffi_customers_update(
    self.as_any(),
    customer_id,
    customer_create_params_to_any(params),
  )
  .wait()
  .cast()
}

///|
/// Delete a customer
pub async fn Stripe::customers_delete(
  self : Stripe,
  customer_id : String,
) -> @core.Any {
  ffi_customers_del(self.as_any(), customer_id).wait()
}
