# @aspect/supabase

MoonBit FFI bindings for [@supabase/supabase-js](https://www.npmjs.com/package/@supabase/supabase-js).

Supabase is an open source Firebase alternative providing database, auth, storage, and realtime features.

## Installation

```bash
moon add aspect/supabase
npm install @supabase/supabase-js
```

## Usage

### Creating a Client

```moonbit no-check
///|
let client = @supabase.create_client(
  "https://your-project.supabase.co", "your-anon-key",
)
```

### Database Queries

```moonbit no-check
// Select all rows
let response = client.from("users").select().execute()!
let users = response.data()

// Select with columns
let response = client.from("users").select(columns="id, name, email").execute()!

// Select with filter
let response = client.from("users")
  .select()
  .eq("status", @core.any("active"))
  .execute()!

// Insert data
let new_user = @core.new_object()
new_user["name"] = @core.any("John")
new_user["email"] = @core.any("john@example.com")
let response = client.from("users").insert(new_user).execute()!

// Update data
let updates = @core.new_object()
updates["name"] = @core.any("Jane")
let response = client.from("users")
  .update(updates)
  .eq("id", @core.any(1))
  .execute()!

// Delete data
let response = client.from("users")
  .delete()
  .eq("id", @core.any(1))
  .execute()!
```

### Authentication

```moonbit no-check
let auth = client.auth()

// Sign up
let result = auth.sign_up("user@example.com", "password123")!
match result.error() {
  Some(err) => println("Error: \{err}")
  None => println("User created: \{result.user()}")
}

// Sign in with password
let result = auth.sign_in_with_password("user@example.com", "password123")!

// Sign in with OAuth
let result = auth.sign_in_with_oauth("github")!

// Sign in with magic link
let result = auth.sign_in_with_otp(email="user@example.com")!

// Get current session
let session = auth.get_session()!

// Get current user
let user = auth.get_user()!

// Sign out
let _ = auth.sign_out()!

// Listen to auth changes
let _ = auth.on_auth_state_change(fn(event, session) {
  println("Auth event: \{event}")
})
```

### Storage

```moonbit no-check
let storage = client.storage()

// List buckets
let buckets = storage.list_buckets()!

// Get a bucket
let bucket = storage.from("avatars")

// Upload a file
let result = bucket.upload("path/to/file.png", file_data)!

// Download a file
let result = bucket.download("path/to/file.png")!

// Get public URL
let url = bucket.get_public_url("path/to/file.png")

// Create signed URL (expires in 3600 seconds)
let result = bucket.create_signed_url("path/to/file.png", 3600)!

// List files
let files = bucket.list(path="folder/")!

// Remove files
let result = bucket.remove(["path/to/file1.png", "path/to/file2.png"])!

// Move file
let result = bucket.move("old/path.png", "new/path.png")!

// Copy file
let result = bucket.copy("original.png", "copy.png")!
```

### Realtime

```moonbit no-check
// Subscribe to database changes
let channel = client.channel("db-changes")
  .on_postgres_changes(
    "INSERT",
    "public",
    table="messages",
    fn(payload) {
      println("New message: \{payload}")
    },
  )
  .subscribe()

// Subscribe to all changes on a table
let channel = client.channel("all-changes")
  .on_postgres_changes(
    "*",
    "public",
    table="posts",
    fn(payload) {
      println("Change: \{payload}")
    },
  )
  .subscribe()

// Broadcast messages
let channel = client.channel("room1")
  .on_broadcast("cursor", fn(payload) {
    println("Cursor moved: \{payload}")
  })
  .subscribe()

// Send broadcast message
let msg = @core.new_object()
msg["type"] = @core.any("broadcast")
msg["event"] = @core.any("cursor")
msg["payload"] = @core.any({ "x": 100, "y": 200 })
let _ = channel.send(msg)!

// Presence
let channel = client.channel("online-users")
  .on_presence("sync", fn(state) {
    println("Presence state: \{state}")
  })
  .subscribe()

// Track presence
let _ = channel.track(@core.any({ "user_id": "123", "online_at": "now" }))!

// Unsubscribe
let _ = channel.unsubscribe()!

// Remove all channels
let _ = client.remove_all_channels()!
```

### Edge Functions

```moonbit no-check
// Invoke an edge function
let options = @core.new_object()
options["body"] = @core.any({ "name": "John" })
let result = client.invoke("my-function", options=options)!
```

### RPC (Remote Procedure Call)

```moonbit no-check
// Call a Postgres function
let args = @core.new_object()
args["user_id"] = @core.any(123)
let result = client.rpc("get_user_stats", args=args)!
let data = result.data()
```

## Filter Methods

| Method | Description |
|--------|-------------|
| `eq` | Equal to |
| `neq` | Not equal to |
| `gt` | Greater than |
| `gte` | Greater than or equal |
| `lt` | Less than |
| `lte` | Less than or equal |
| `like` | Pattern matching (case sensitive) |
| `ilike` | Pattern matching (case insensitive) |
| `in_` | Value in array |
| `is` | Is null/true/false |
| `contains` | Array contains |
| `contained_by` | Array contained by |
| `overlaps` | Arrays overlap |
| `text_search` | Full-text search |
| `or` | OR conditions |
| `not` | Negate a filter |
| `match_` | Match multiple columns |

## Modifier Methods

| Method | Description |
|--------|-------------|
| `order` | Order results |
| `limit` | Limit number of rows |
| `range` | Paginate results |
| `single` | Return single row |
| `maybe_single` | Return 0 or 1 row |
