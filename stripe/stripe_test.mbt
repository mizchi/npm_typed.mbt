///|
/// Tests for Stripe bindings
/// Note: Most tests require a real Stripe API key, so they are marked no-check

///|
test "checkout mode to string" {
  inspect(
    @stripe.checkout_mode_to_string(@stripe.CheckoutMode::Payment),
    content="payment",
  )
  inspect(
    @stripe.checkout_mode_to_string(@stripe.CheckoutMode::Setup),
    content="setup",
  )
  inspect(
    @stripe.checkout_mode_to_string(@stripe.CheckoutMode::Subscription),
    content="subscription",
  )
}

///|
test "price interval to string" {
  inspect(
    @stripe.price_interval_to_string(@stripe.PriceInterval::Day),
    content="day",
  )
  inspect(
    @stripe.price_interval_to_string(@stripe.PriceInterval::Week),
    content="week",
  )
  inspect(
    @stripe.price_interval_to_string(@stripe.PriceInterval::Month),
    content="month",
  )
  inspect(
    @stripe.price_interval_to_string(@stripe.PriceInterval::Year),
    content="year",
  )
}

///|
test "price billing scheme to string" {
  inspect(
    @stripe.price_billing_scheme_to_string(@stripe.PriceBillingScheme::PerUnit),
    content="per_unit",
  )
  inspect(
    @stripe.price_billing_scheme_to_string(@stripe.PriceBillingScheme::Tiered),
    content="tiered",
  )
}

///|
test "event type constants" {
  inspect(
    @stripe.EVENT_CHECKOUT_SESSION_COMPLETED,
    content="checkout.session.completed",
  )
  inspect(
    @stripe.EVENT_CUSTOMER_SUBSCRIPTION_DELETED,
    content="customer.subscription.deleted",
  )
  inspect(@stripe.EVENT_INVOICE_PAID, content="invoice.paid")
}

///|
test "stripe config to any" {
  let config : @stripe.StripeConfig = {
    api_version: Some("2024-12-18"),
    max_network_retries: Some(3),
    timeout: Some(30000),
  }
  let any_config = @stripe.stripe_config_to_any(config)
  let api_version : String = any_config["apiVersion"].cast()
  let max_retries : Int = any_config["maxNetworkRetries"].cast()
  let timeout : Int = any_config["timeout"].cast()
  inspect(api_version, content="2024-12-18")
  inspect(max_retries, content="3")
  inspect(timeout, content="30000")
}

///|
test "checkout params to any" {
  let params : @stripe.CheckoutSessionCreateParams = {
    mode: @stripe.CheckoutMode::Subscription,
    line_items: [@stripe.LineItem::{ price: "price_xxx", quantity: 2 }],
    success_url: "https://example.com/success",
    cancel_url: "https://example.com/cancel",
    customer_email: Some("test@example.com"),
    client_reference_id: None,
    metadata: None,
  }
  let any_params = @stripe.checkout_params_to_any(params)
  let mode : String = any_params["mode"].cast()
  let success_url : String = any_params["success_url"].cast()
  let customer_email : String = any_params["customer_email"].cast()
  inspect(mode, content="subscription")
  inspect(success_url, content="https://example.com/success")
  inspect(customer_email, content="test@example.com")
}

///|
test "customer create params to any" {
  let params : @stripe.CustomerCreateParams = {
    email: Some("user@example.com"),
    name: Some("John Doe"),
    description: Some("A test customer"),
    metadata: None,
  }
  let any_params = @stripe.customer_create_params_to_any(params)
  let email : String = any_params["email"].cast()
  let name : String = any_params["name"].cast()
  let description : String = any_params["description"].cast()
  inspect(email, content="user@example.com")
  inspect(name, content="John Doe")
  inspect(description, content="A test customer")
}

///|
test "subscription create params to any" {
  let params : @stripe.SubscriptionCreateParams = {
    customer: "cus_xxx",
    items: [@stripe.SubscriptionItem::{ price: "price_xxx", quantity: Some(1) }],
    payment_behavior: Some("default_incomplete"),
    default_payment_method: None,
    metadata: None,
  }
  let any_params = @stripe.subscription_create_params_to_any(params)
  let customer : String = any_params["customer"].cast()
  let payment_behavior : String = any_params["payment_behavior"].cast()
  inspect(customer, content="cus_xxx")
  inspect(payment_behavior, content="default_incomplete")
}

///|
test "product create params to any" {
  let params : @stripe.ProductCreateParams = {
    name: "My Product",
    description: Some("A great product"),
    active: Some(true),
    metadata: None,
  }
  let any_params = @stripe.product_create_params_to_any(params)
  let name : String = any_params["name"].cast()
  let description : String = any_params["description"].cast()
  let active : Bool = any_params["active"].cast()
  inspect(name, content="My Product")
  inspect(description, content="A great product")
  inspect(active, content="true")
}

///|
test "price create params to any with recurring" {
  let recurring : @stripe.PriceRecurring = {
    interval: @stripe.PriceInterval::Month,
    interval_count: Some(1),
  }
  let params : @stripe.PriceCreateParams = {
    product: "prod_xxx",
    currency: "usd",
    unit_amount: Some(1999),
    billing_scheme: None,
    recurring: Some(recurring),
    metadata: None,
  }
  let any_params = @stripe.price_create_params_to_any(params)
  let product : String = any_params["product"].cast()
  let currency : String = any_params["currency"].cast()
  let unit_amount : Int = any_params["unit_amount"].cast()
  inspect(product, content="prod_xxx")
  inspect(currency, content="usd")
  inspect(unit_amount, content="1999")
  let recurring_any = any_params["recurring"]
  let interval : String = recurring_any["interval"].cast()
  let interval_count : Int = recurring_any["interval_count"].cast()
  inspect(interval, content="month")
  inspect(interval_count, content="1")
}
