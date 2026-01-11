///|
/// Stripe Products and Prices API
/// https://stripe.com/docs/api/products
/// https://stripe.com/docs/api/prices

///|
/// Product object
#external
pub type Product

///|
pub fn Product::as_any(self : Product) -> @core.Any = "%identity"

///|
pub fn Product::id(self : Product) -> String {
  self.as_any()["id"].cast()
}

///|
pub fn Product::name(self : Product) -> String {
  self.as_any()["name"].cast()
}

///|
pub fn Product::active(self : Product) -> Bool {
  self.as_any()["active"].cast()
}

///|
pub fn Product::description(self : Product) -> String? {
  let desc = self.as_any()["description"]
  if @core.is_nullish(desc) {
    None
  } else {
    Some(desc.cast())
  }
}

///|
/// Price object
#external
pub type Price

///|
pub fn Price::as_any(self : Price) -> @core.Any = "%identity"

///|
pub fn Price::id(self : Price) -> String {
  self.as_any()["id"].cast()
}

///|
pub fn Price::product(self : Price) -> String {
  self.as_any()["product"].cast()
}

///|
pub fn Price::currency(self : Price) -> String {
  self.as_any()["currency"].cast()
}

///|
pub fn Price::unit_amount(self : Price) -> Int? {
  let amount = self.as_any()["unit_amount"]
  if @core.is_nullish(amount) {
    None
  } else {
    Some(amount.cast())
  }
}

///|
pub fn Price::active(self : Price) -> Bool {
  self.as_any()["active"].cast()
}

///|
/// Price billing scheme type
pub(all) enum PriceBillingScheme {
  PerUnit
  Tiered
}

///|
pub fn price_billing_scheme_to_string(scheme : PriceBillingScheme) -> String {
  match scheme {
    PerUnit => "per_unit"
    Tiered => "tiered"
  }
}

///|
/// Price recurring interval
pub(all) enum PriceInterval {
  Day
  Week
  Month
  Year
}

///|
pub fn price_interval_to_string(interval : PriceInterval) -> String {
  match interval {
    Day => "day"
    Week => "week"
    Month => "month"
    Year => "year"
  }
}

///|
/// Recurring price configuration
pub(all) struct PriceRecurring {
  interval : PriceInterval
  interval_count : Int?
}

///|
/// Product creation parameters
pub(all) struct ProductCreateParams {
  name : String
  description : String?
  active : Bool?
  metadata : Map[String, String]?
}

///|
pub fn product_create_params_to_any(params : ProductCreateParams) -> @core.Any {
  let obj = @core.new_object()
  obj["name"] = @core.any(params.name)
  if params.description is Some(v) {
    obj["description"] = @core.any(v)
  }
  if params.active is Some(v) {
    obj["active"] = @core.any(v)
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
/// Price creation parameters
pub(all) struct PriceCreateParams {
  product : String
  currency : String
  unit_amount : Int?
  billing_scheme : PriceBillingScheme?
  recurring : PriceRecurring?
  metadata : Map[String, String]?
}

///|
pub fn price_create_params_to_any(params : PriceCreateParams) -> @core.Any {
  let obj = @core.new_object()
  obj["product"] = @core.any(params.product)
  obj["currency"] = @core.any(params.currency)
  if params.unit_amount is Some(v) {
    obj["unit_amount"] = @core.any(v)
  }
  if params.billing_scheme is Some(v) {
    obj["billing_scheme"] = @core.any(price_billing_scheme_to_string(v))
  }
  if params.recurring is Some(r) {
    let rec_obj = @core.new_object()
    rec_obj["interval"] = @core.any(price_interval_to_string(r.interval))
    if r.interval_count is Some(c) {
      rec_obj["interval_count"] = @core.any(c)
    }
    obj["recurring"] = rec_obj
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
extern "js" fn ffi_products_create(
  stripe : @core.Any,
  params : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (stripe, params) => stripe.products.create(params)

///|
extern "js" fn ffi_products_retrieve(
  stripe : @core.Any,
  product_id : String,
) -> @js.Promise[@core.Any] =
  #| (stripe, productId) => stripe.products.retrieve(productId)

///|
extern "js" fn ffi_prices_create(
  stripe : @core.Any,
  params : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (stripe, params) => stripe.prices.create(params)

///|
extern "js" fn ffi_prices_retrieve(
  stripe : @core.Any,
  price_id : String,
) -> @js.Promise[@core.Any] =
  #| (stripe, priceId) => stripe.prices.retrieve(priceId)

///|
/// Create a product
pub async fn Stripe::products_create(
  self : Stripe,
  params : ProductCreateParams,
) -> Product {
  ffi_products_create(self.as_any(), product_create_params_to_any(params))
  .wait()
  .cast()
}

///|
/// Retrieve a product by ID
pub async fn Stripe::products_retrieve(
  self : Stripe,
  product_id : String,
) -> Product {
  ffi_products_retrieve(self.as_any(), product_id).wait().cast()
}

///|
/// Create a price
pub async fn Stripe::prices_create(
  self : Stripe,
  params : PriceCreateParams,
) -> Price {
  ffi_prices_create(self.as_any(), price_create_params_to_any(params))
  .wait()
  .cast()
}

///|
/// Retrieve a price by ID
pub async fn Stripe::prices_retrieve(self : Stripe, price_id : String) -> Price {
  ffi_prices_retrieve(self.as_any(), price_id).wait().cast()
}
