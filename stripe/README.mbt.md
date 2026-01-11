# @mizchi/npm_typed/stripe

MoonBit bindings for [Stripe](https://stripe.com/) payment processing SDK.

## Features

- Stripe client initialization
- Checkout Sessions (payment/subscription)
- Customers CRUD
- Subscriptions management
- Products and Prices
- Webhook signature verification

## Installation

```bash
moon add mizchi/npm_typed
```

Add to your `moon.pkg.json`:

```json
{
  "import": ["mizchi/npm_typed/stripe"]
}
```

## Usage

### Initialize Stripe Client

```mbt nocheck
///|
async fn main {
  let stripe = @stripe.Stripe::new("sk_test_xxx")

  // With config
  let stripe_with_config = @stripe.Stripe::new("sk_test_xxx", config={
    api_version: Some("2024-12-18"),
  })

}
```

### Create Checkout Session

```mbt nocheck
///|
async fn create_checkout {
  let stripe = @stripe.Stripe::new("sk_test_xxx")
  let session = stripe.checkout_sessions_create({
    mode: Subscription,
    line_items: [{ price: "price_xxx", quantity: 1 }],
    success_url: "https://example.com/success?session_id={CHECKOUT_SESSION_ID}",
    cancel_url: "https://example.com/cancel",
    customer_email: Some("user@example.com"),
  })

  // Redirect customer to session.url()
  println(session.url())
}
```

### Handle Webhooks

```mbt nocheck
///|
fn handle_webhook(payload : String, signature : String) -> Unit raise {
  let stripe = @stripe.Stripe::new("sk_test_xxx")
  let event = stripe.webhooks_construct_event(
    payload, signature, "whsec_xxx", // endpoint secret
  )
  match event.event_type() {
    @stripe.EVENT_CHECKOUT_SESSION_COMPLETED => {
      let session : @stripe.CheckoutSession = event.data().object().cast()
      println("Payment completed for: \{session.customer_email()}")
    }
    @stripe.EVENT_CUSTOMER_SUBSCRIPTION_DELETED => {
      let subscription : @stripe.Subscription = event.data().object().cast()
      println("Subscription canceled: \{subscription.id()}")
    }
    _ => println("Unhandled event: \{event.event_type()}")
  }
}
```

### Manage Customers

```mbt nocheck
///|
async fn manage_customers {
  let stripe = @stripe.Stripe::new("sk_test_xxx")

  // Create customer
  let customer = stripe.customers_create({
    email: Some("user@example.com"),
    name: Some("John Doe"),
  })

  // Retrieve customer
  let retrieved = stripe.customers_retrieve(customer.id())

  // Update customer
  let updated = stripe.customers_update(customer.id(), {
    name: Some("Jane Doe"),
  })

}
```

### Manage Subscriptions

```mbt nocheck
///|
async fn manage_subscriptions {
  let stripe = @stripe.Stripe::new("sk_test_xxx")

  // Create subscription
  let subscription = stripe.subscriptions_create({
    customer: "cus_xxx",
    items: [{ price: "price_xxx" }],
  })

  // Cancel at period end
  let updated = stripe.subscriptions_update(subscription.id(), {
    cancel_at_period_end: Some(true),
  })

  // Cancel immediately
  let canceled = stripe.subscriptions_cancel(subscription.id())

}
```

### Create Products and Prices

```mbt nocheck
///|
async fn create_product_and_price {
  let stripe = @stripe.Stripe::new("sk_test_xxx")

  // Create product
  let product = stripe.products_create({
    name: "My SaaS Product",
    description: Some("A great product"),
  })

  // Create monthly price
  let price = stripe.prices_create({
    product: product.id(),
    currency: "usd",
    unit_amount: Some(1999), // $19.99
    recurring: Some({ interval: Month }),
  })

}
```

## API Reference

### Stripe

- `Stripe::new(api_key, config?)` - Create client
- `checkout_sessions_create(params)` - Create checkout session
- `checkout_sessions_retrieve(id)` - Get checkout session
- `customers_create(params)` - Create customer
- `customers_retrieve(id)` - Get customer
- `customers_update(id, params)` - Update customer
- `customers_delete(id)` - Delete customer
- `subscriptions_create(params)` - Create subscription
- `subscriptions_retrieve(id)` - Get subscription
- `subscriptions_update(id, params)` - Update subscription
- `subscriptions_cancel(id)` - Cancel subscription
- `products_create(params)` - Create product
- `products_retrieve(id)` - Get product
- `prices_create(params)` - Create price
- `prices_retrieve(id)` - Get price
- `webhooks_construct_event(payload, signature, secret)` - Verify webhook

### Event Types

- `EVENT_CHECKOUT_SESSION_COMPLETED`
- `EVENT_CHECKOUT_SESSION_EXPIRED`
- `EVENT_CUSTOMER_SUBSCRIPTION_CREATED`
- `EVENT_CUSTOMER_SUBSCRIPTION_UPDATED`
- `EVENT_CUSTOMER_SUBSCRIPTION_DELETED`
- `EVENT_INVOICE_PAID`
- `EVENT_INVOICE_PAYMENT_FAILED`
- `EVENT_PAYMENT_INTENT_SUCCEEDED`
- `EVENT_PAYMENT_INTENT_FAILED`

## Integration with Hono

```mbt nocheck
///|
async fn create_hono_app {
  let app = @hono.Hono::new()
  let stripe = @stripe.Stripe::new("sk_test_xxx")

  // Checkout endpoint
  app.get("/checkout", async fn(c) {
    let session = stripe.checkout_sessions_create({
      mode: Subscription,
      line_items: [{ price: "price_xxx", quantity: 1 }],
      success_url: "https://example.com/success",
      cancel_url: "https://example.com/cancel",
    })
    c.redirect(session.url().unwrap())
  })

  // Webhook endpoint
  app.post("/webhook", async fn(c) {
    let payload = c.text()
    let signature = c.req().header("stripe-signature").unwrap()
    try {
      let event = stripe.webhooks_construct_event(
        payload, signature, "whsec_xxx",
      )
      // Handle event...
      c.json({ "received": true })
    } catch {
      _ => c.text("Webhook Error", status_code=400)
    }
  })
  app
}
```

## License

MIT
