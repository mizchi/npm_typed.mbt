///|
/// Supabase - The open source Firebase alternative
/// https://supabase.com/docs/reference/javascript
///
/// MoonBit FFI bindings for @supabase/supabase-js

///|
/// Supabase client instance
#external
pub type SupabaseClient

///|
pub fn SupabaseClient::as_any(self : SupabaseClient) -> @core.Any = "%identity"

///|
/// Supabase Auth client
#external
pub type AuthClient

///|
pub fn AuthClient::as_any(self : AuthClient) -> @core.Any = "%identity"

///|
/// Supabase Storage client
#external
pub type StorageClient

///|
pub fn StorageClient::as_any(self : StorageClient) -> @core.Any = "%identity"

///|
/// Storage bucket
#external
pub type StorageBucket

///|
pub fn StorageBucket::as_any(self : StorageBucket) -> @core.Any = "%identity"

///|
/// Realtime channel
#external
pub type RealtimeChannel

///|
pub fn RealtimeChannel::as_any(self : RealtimeChannel) -> @core.Any = "%identity"

///|
/// Query builder for database operations
#external
pub type QueryBuilder

///|
pub fn QueryBuilder::as_any(self : QueryBuilder) -> @core.Any = "%identity"

///|
/// Filter builder (extends QueryBuilder with filter methods)
#external
pub type FilterBuilder

///|
pub fn FilterBuilder::as_any(self : FilterBuilder) -> @core.Any = "%identity"

///|
/// PostgrestResponse - response from database queries
#external
pub type PostgrestResponse

///|
pub fn PostgrestResponse::as_any(self : PostgrestResponse) -> @core.Any = "%identity"

///|
/// Get data from response
pub fn PostgrestResponse::data(self : PostgrestResponse) -> @core.Any {
  self.as_any()["data"]
}

///|
/// Get error from response
pub fn PostgrestResponse::error(self : PostgrestResponse) -> @core.Any? {
  let err = self.as_any()["error"]
  if @core.is_nullish(err) {
    None
  } else {
    Some(err)
  }
}

///|
/// Get count from response (when count option is used)
pub fn PostgrestResponse::count(self : PostgrestResponse) -> Int? {
  let c = self.as_any()["count"]
  if @core.is_nullish(c) {
    None
  } else {
    Some(c.cast())
  }
}

///|
/// Get status code
pub fn PostgrestResponse::status(self : PostgrestResponse) -> Int {
  self.as_any()["status"].cast()
}

///|
/// Get status text
pub fn PostgrestResponse::status_text(self : PostgrestResponse) -> String {
  self.as_any()["statusText"].cast()
}

///|
/// Auth response type
#external
pub type AuthResponse

///|
pub fn AuthResponse::as_any(self : AuthResponse) -> @core.Any = "%identity"

///|
/// Get user from auth response
pub fn AuthResponse::user(self : AuthResponse) -> @core.Any? {
  let data = self.as_any()["data"]
  if @core.is_nullish(data) {
    return None
  }
  let user = data["user"]
  if @core.is_nullish(user) {
    None
  } else {
    Some(user)
  }
}

///|
/// Get session from auth response
pub fn AuthResponse::session(self : AuthResponse) -> @core.Any? {
  let data = self.as_any()["data"]
  if @core.is_nullish(data) {
    return None
  }
  let session = data["session"]
  if @core.is_nullish(session) {
    None
  } else {
    Some(session)
  }
}

///|
/// Get error from auth response
pub fn AuthResponse::error(self : AuthResponse) -> @core.Any? {
  let err = self.as_any()["error"]
  if @core.is_nullish(err) {
    None
  } else {
    Some(err)
  }
}

///|
/// Session response type
#external
pub type SessionResponse

///|
pub fn SessionResponse::as_any(self : SessionResponse) -> @core.Any = "%identity"

///|
/// Get session from session response
pub fn SessionResponse::session(self : SessionResponse) -> @core.Any? {
  let data = self.as_any()["data"]
  if @core.is_nullish(data) {
    return None
  }
  let session = data["session"]
  if @core.is_nullish(session) {
    None
  } else {
    Some(session)
  }
}

///|
/// Get error from session response
pub fn SessionResponse::error(self : SessionResponse) -> @core.Any? {
  let err = self.as_any()["error"]
  if @core.is_nullish(err) {
    None
  } else {
    Some(err)
  }
}

///|
/// User response type
#external
pub type UserResponse

///|
pub fn UserResponse::as_any(self : UserResponse) -> @core.Any = "%identity"

///|
/// Get user from user response
pub fn UserResponse::user(self : UserResponse) -> @core.Any? {
  let data = self.as_any()["data"]
  if @core.is_nullish(data) {
    return None
  }
  let user = data["user"]
  if @core.is_nullish(user) {
    None
  } else {
    Some(user)
  }
}

///|
/// Get error from user response
pub fn UserResponse::error(self : UserResponse) -> @core.Any? {
  let err = self.as_any()["error"]
  if @core.is_nullish(err) {
    None
  } else {
    Some(err)
  }
}

// ============================================================
// Client Creation
// ============================================================

///|
extern "js" fn ffi_create_client(
  supabase_url : String,
  supabase_key : String,
) -> @js.Promise[@core.Any] =
  #| (url, key) => import("@supabase/supabase-js").then(m => m.createClient(url, key))

///|
extern "js" fn ffi_create_client_with_options(
  supabase_url : String,
  supabase_key : String,
  options : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (url, key, options) => import("@supabase/supabase-js").then(m => m.createClient(url, key, options))

///|
/// Create a Supabase client
///
/// Example:
/// ```moonbit no-check
/// let client = @supabase.create_client("https://xxx.supabase.co", "your-anon-key")
/// ```
pub async fn create_client(
  supabase_url : String,
  supabase_key : String,
  options? : @core.Any,
) -> SupabaseClient {
  match options {
    Some(opts) =>
      ffi_create_client_with_options(supabase_url, supabase_key, opts)
      .wait()
      .cast()
    None => ffi_create_client(supabase_url, supabase_key).wait().cast()
  }
}

// ============================================================
// Auth API
// ============================================================

///|
/// Get the auth client
pub fn SupabaseClient::auth(self : SupabaseClient) -> AuthClient {
  self.as_any()["auth"].cast()
}

///|
/// Sign up with email and password
pub async fn AuthClient::sign_up(
  self : AuthClient,
  email : String,
  password : String,
) -> AuthResponse {
  let credentials = @core.new_object()
  credentials["email"] = @core.any(email)
  credentials["password"] = @core.any(password)
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("signUp", [credentials])
    .cast()
  promise.wait().cast()
}

///|
/// Sign up with email, password and additional options
pub async fn AuthClient::sign_up_with_options(
  self : AuthClient,
  email : String,
  password : String,
  options : @core.Any,
) -> AuthResponse {
  let credentials = @core.new_object()
  credentials["email"] = @core.any(email)
  credentials["password"] = @core.any(password)
  credentials["options"] = options
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("signUp", [credentials])
    .cast()
  promise.wait().cast()
}

///|
/// Sign in with email and password
pub async fn AuthClient::sign_in_with_password(
  self : AuthClient,
  email : String,
  password : String,
) -> AuthResponse {
  let credentials = @core.new_object()
  credentials["email"] = @core.any(email)
  credentials["password"] = @core.any(password)
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("signInWithPassword", [credentials])
    .cast()
  promise.wait().cast()
}

///|
/// Sign in with OAuth provider
pub async fn AuthClient::sign_in_with_oauth(
  self : AuthClient,
  provider : String,
  options? : @core.Any,
) -> AuthResponse {
  let params = @core.new_object()
  params["provider"] = @core.any(provider)
  match options {
    Some(opts) => params["options"] = opts
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("signInWithOAuth", [params])
    .cast()
  promise.wait().cast()
}

///|
/// Sign in with OTP (magic link or SMS)
pub async fn AuthClient::sign_in_with_otp(
  self : AuthClient,
  email? : String,
  phone? : String,
  options? : @core.Any,
) -> AuthResponse {
  let params = @core.new_object()
  match email {
    Some(e) => params["email"] = @core.any(e)
    None => ()
  }
  match phone {
    Some(p) => params["phone"] = @core.any(p)
    None => ()
  }
  match options {
    Some(opts) => params["options"] = opts
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("signInWithOtp", [params])
    .cast()
  promise.wait().cast()
}

///|
/// Sign out the current user
pub async fn AuthClient::sign_out(self : AuthClient) -> @core.Any? {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("signOut", [])
    .cast()
  let result = promise.wait()
  let err = result["error"]
  if @core.is_nullish(err) {
    None
  } else {
    Some(err)
  }
}

///|
/// Get the current session
pub async fn AuthClient::get_session(self : AuthClient) -> SessionResponse {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("getSession", [])
    .cast()
  promise.wait().cast()
}

///|
/// Get the current user
pub async fn AuthClient::get_user(self : AuthClient) -> UserResponse {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("getUser", [])
    .cast()
  promise.wait().cast()
}

///|
/// Set the session
pub async fn AuthClient::set_session(
  self : AuthClient,
  access_token : String,
  refresh_token : String,
) -> AuthResponse {
  let params = @core.new_object()
  params["access_token"] = @core.any(access_token)
  params["refresh_token"] = @core.any(refresh_token)
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("setSession", [params])
    .cast()
  promise.wait().cast()
}

///|
/// Refresh the session
pub async fn AuthClient::refresh_session(self : AuthClient) -> AuthResponse {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("refreshSession", [])
    .cast()
  promise.wait().cast()
}

///|
/// Update the current user
pub async fn AuthClient::update_user(
  self : AuthClient,
  attributes : @core.Any,
) -> UserResponse {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("updateUser", [attributes])
    .cast()
  promise.wait().cast()
}

///|
/// Reset password for email
pub async fn AuthClient::reset_password_for_email(
  self : AuthClient,
  email : String,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(email)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("resetPasswordForEmail", args)
    .cast()
  promise.wait()
}

///|
/// Subscribe to auth state changes
pub fn AuthClient::on_auth_state_change(
  self : AuthClient,
  callback : (@core.Any, @core.Any) -> Unit,
) -> @core.Any {
  self.as_any()._call("onAuthStateChange", [@js.from_fn2(callback)])
}

// ============================================================
// Database API
// ============================================================

///|
/// Get a query builder for a table
pub fn SupabaseClient::from(
  self : SupabaseClient,
  table : String,
) -> QueryBuilder {
  self.as_any()._call("from", [@core.any(table)]).cast()
}

///|
/// Select data from the table
pub fn QueryBuilder::select(
  self : QueryBuilder,
  columns? : String,
  options? : @core.Any,
) -> FilterBuilder {
  let args : Array[@core.Any] = []
  match columns {
    Some(c) => args.push(@core.any(c))
    None => args.push(@core.any("*"))
  }
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("select", args).cast()
}

///|
/// Insert data into the table
pub fn QueryBuilder::insert(
  self : QueryBuilder,
  values : @core.Any,
  options? : @core.Any,
) -> FilterBuilder {
  let args : Array[@core.Any] = [values]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("insert", args).cast()
}

///|
/// Update data in the table
pub fn QueryBuilder::update(
  self : QueryBuilder,
  values : @core.Any,
  options? : @core.Any,
) -> FilterBuilder {
  let args : Array[@core.Any] = [values]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("update", args).cast()
}

///|
/// Upsert data into the table
pub fn QueryBuilder::upsert(
  self : QueryBuilder,
  values : @core.Any,
  options? : @core.Any,
) -> FilterBuilder {
  let args : Array[@core.Any] = [values]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("upsert", args).cast()
}

///|
/// Delete data from the table
pub fn QueryBuilder::delete(
  self : QueryBuilder,
  options? : @core.Any,
) -> FilterBuilder {
  let args : Array[@core.Any] = []
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("delete", args).cast()
}

// ============================================================
// Filter Methods
// ============================================================

///|
/// Filter by equality
pub fn FilterBuilder::eq(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("eq", [@core.any(column), value]).cast()
}

///|
/// Filter by inequality
pub fn FilterBuilder::neq(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("neq", [@core.any(column), value]).cast()
}

///|
/// Filter by greater than
pub fn FilterBuilder::gt(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("gt", [@core.any(column), value]).cast()
}

///|
/// Filter by greater than or equal
pub fn FilterBuilder::gte(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("gte", [@core.any(column), value]).cast()
}

///|
/// Filter by less than
pub fn FilterBuilder::lt(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("lt", [@core.any(column), value]).cast()
}

///|
/// Filter by less than or equal
pub fn FilterBuilder::lte(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("lte", [@core.any(column), value]).cast()
}

///|
/// Filter by LIKE pattern
pub fn FilterBuilder::like(
  self : FilterBuilder,
  column : String,
  pattern : String,
) -> FilterBuilder {
  self.as_any()._call("like", [@core.any(column), @core.any(pattern)]).cast()
}

///|
/// Filter by ILIKE pattern (case insensitive)
pub fn FilterBuilder::ilike(
  self : FilterBuilder,
  column : String,
  pattern : String,
) -> FilterBuilder {
  self.as_any()._call("ilike", [@core.any(column), @core.any(pattern)]).cast()
}

///|
/// Filter by value in array
pub fn FilterBuilder::in_(
  self : FilterBuilder,
  column : String,
  values : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("in", [@core.any(column), values]).cast()
}

///|
/// Filter by value is null
pub fn FilterBuilder::is_(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("is", [@core.any(column), value]).cast()
}

///|
/// Filter by array contains
pub fn FilterBuilder::contains(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("contains", [@core.any(column), value]).cast()
}

///|
/// Filter by array contained by
pub fn FilterBuilder::contained_by(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("containedBy", [@core.any(column), value]).cast()
}

///|
/// Filter by range contains
pub fn FilterBuilder::range_gt(
  self : FilterBuilder,
  column : String,
  range : String,
) -> FilterBuilder {
  self.as_any()._call("rangeGt", [@core.any(column), @core.any(range)]).cast()
}

///|
/// Filter by range gte
pub fn FilterBuilder::range_gte(
  self : FilterBuilder,
  column : String,
  range : String,
) -> FilterBuilder {
  self.as_any()._call("rangeGte", [@core.any(column), @core.any(range)]).cast()
}

///|
/// Filter by range lt
pub fn FilterBuilder::range_lt(
  self : FilterBuilder,
  column : String,
  range : String,
) -> FilterBuilder {
  self.as_any()._call("rangeLt", [@core.any(column), @core.any(range)]).cast()
}

///|
/// Filter by range lte
pub fn FilterBuilder::range_lte(
  self : FilterBuilder,
  column : String,
  range : String,
) -> FilterBuilder {
  self.as_any()._call("rangeLte", [@core.any(column), @core.any(range)]).cast()
}

///|
/// Filter by range adjacent
pub fn FilterBuilder::range_adjacent(
  self : FilterBuilder,
  column : String,
  range : String,
) -> FilterBuilder {
  self
  .as_any()
  ._call("rangeAdjacent", [@core.any(column), @core.any(range)])
  .cast()
}

///|
/// Filter by overlaps
pub fn FilterBuilder::overlaps(
  self : FilterBuilder,
  column : String,
  value : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("overlaps", [@core.any(column), value]).cast()
}

///|
/// Filter by text search
pub fn FilterBuilder::text_search(
  self : FilterBuilder,
  column : String,
  query : String,
  options? : @core.Any,
) -> FilterBuilder {
  let args : Array[@core.Any] = [@core.any(column), @core.any(query)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("textSearch", args).cast()
}

///|
/// Apply OR filter
pub fn FilterBuilder::or(
  self : FilterBuilder,
  filters : String,
  options? : @core.Any,
) -> FilterBuilder {
  let args : Array[@core.Any] = [@core.any(filters)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("or", args).cast()
}

///|
/// Filter with NOT
pub fn FilterBuilder::not(
  self : FilterBuilder,
  column : String,
  operator : String,
  value : @core.Any,
) -> FilterBuilder {
  self
  .as_any()
  ._call("not", [@core.any(column), @core.any(operator), value])
  .cast()
}

///|
/// Match multiple columns
pub fn FilterBuilder::match_(
  self : FilterBuilder,
  query : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("match", [query]).cast()
}

// ============================================================
// Modifier Methods
// ============================================================

///|
/// Order by column
pub fn FilterBuilder::order(
  self : FilterBuilder,
  column : String,
  ascending? : Bool,
  nulls_first? : Bool,
  foreign_table? : String,
) -> FilterBuilder {
  let options = @core.new_object()
  match ascending {
    Some(a) => options["ascending"] = @core.any(a)
    None => ()
  }
  match nulls_first {
    Some(n) => options["nullsFirst"] = @core.any(n)
    None => ()
  }
  match foreign_table {
    Some(f) => options["foreignTable"] = @core.any(f)
    None => ()
  }
  self.as_any()._call("order", [@core.any(column), options]).cast()
}

///|
/// Limit the number of rows
pub fn FilterBuilder::limit(
  self : FilterBuilder,
  count : Int,
  foreign_table? : String,
) -> FilterBuilder {
  let options = @core.new_object()
  match foreign_table {
    Some(f) => options["foreignTable"] = @core.any(f)
    None => ()
  }
  self.as_any()._call("limit", [@core.any(count), options]).cast()
}

///|
/// Limit the result to a range
pub fn FilterBuilder::range(
  self : FilterBuilder,
  from : Int,
  to : Int,
  foreign_table? : String,
) -> FilterBuilder {
  let options = @core.new_object()
  match foreign_table {
    Some(f) => options["foreignTable"] = @core.any(f)
    None => ()
  }
  self.as_any()._call("range", [@core.any(from), @core.any(to), options]).cast()
}

///|
/// Return a single row
pub fn FilterBuilder::single(self : FilterBuilder) -> FilterBuilder {
  self.as_any()._call("single", []).cast()
}

///|
/// Return at most one row
pub fn FilterBuilder::maybe_single(self : FilterBuilder) -> FilterBuilder {
  self.as_any()._call("maybeSingle", []).cast()
}

///|
/// Abort signal
pub fn FilterBuilder::abort_signal(
  self : FilterBuilder,
  signal : @core.Any,
) -> FilterBuilder {
  self.as_any()._call("abortSignal", [signal]).cast()
}

///|
/// Execute the query and return response
pub async fn FilterBuilder::execute(self : FilterBuilder) -> PostgrestResponse {
  let promise : @js.Promise[@core.Any] = self.as_any().cast()
  promise.wait().cast()
}

// ============================================================
// Storage API
// ============================================================

///|
/// Get the storage client
pub fn SupabaseClient::storage(self : SupabaseClient) -> StorageClient {
  self.as_any()["storage"].cast()
}

///|
/// Get a storage bucket
pub fn StorageClient::from(
  self : StorageClient,
  bucket : String,
) -> StorageBucket {
  self.as_any()._call("from", [@core.any(bucket)]).cast()
}

///|
/// List all buckets
pub async fn StorageClient::list_buckets(self : StorageClient) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("listBuckets", [])
    .cast()
  promise.wait()
}

///|
/// Get a bucket by ID
pub async fn StorageClient::get_bucket(
  self : StorageClient,
  id : String,
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("getBucket", [@core.any(id)])
    .cast()
  promise.wait()
}

///|
/// Create a new bucket
pub async fn StorageClient::create_bucket(
  self : StorageClient,
  id : String,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(id)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("createBucket", args)
    .cast()
  promise.wait()
}

///|
/// Delete a bucket
pub async fn StorageClient::delete_bucket(
  self : StorageClient,
  id : String,
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("deleteBucket", [@core.any(id)])
    .cast()
  promise.wait()
}

///|
/// Empty a bucket
pub async fn StorageClient::empty_bucket(
  self : StorageClient,
  id : String,
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("emptyBucket", [@core.any(id)])
    .cast()
  promise.wait()
}

///|
/// Upload a file to storage
pub async fn StorageBucket::upload(
  self : StorageBucket,
  path : String,
  file : @core.Any,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(path), file]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("upload", args)
    .cast()
  promise.wait()
}

///|
/// Download a file from storage
pub async fn StorageBucket::download(
  self : StorageBucket,
  path : String,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(path)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("download", args)
    .cast()
  promise.wait()
}

///|
/// Get public URL for a file
pub fn StorageBucket::get_public_url(
  self : StorageBucket,
  path : String,
  options? : @core.Any,
) -> String {
  let args : Array[@core.Any] = [@core.any(path)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let result = self.as_any()._call("getPublicUrl", args)
  let public_url : String = result["data"]["publicUrl"].cast()
  public_url
}

///|
/// Create a signed URL for a file
pub async fn StorageBucket::create_signed_url(
  self : StorageBucket,
  path : String,
  expires_in : Int,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(path), @core.any(expires_in)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("createSignedUrl", args)
    .cast()
  promise.wait()
}

///|
/// List files in a folder
pub async fn StorageBucket::list(
  self : StorageBucket,
  path? : String,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = []
  match path {
    Some(p) => args.push(@core.any(p))
    None => args.push(@core.any(""))
  }
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("list", args)
    .cast()
  promise.wait()
}

///|
/// Remove files from storage
pub async fn StorageBucket::remove(
  self : StorageBucket,
  paths : Array[String],
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("remove", [@core.any(paths)])
    .cast()
  promise.wait()
}

///|
/// Move a file
pub async fn StorageBucket::move_(
  self : StorageBucket,
  from_path : String,
  to_path : String,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(from_path), @core.any(to_path)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("move", args)
    .cast()
  promise.wait()
}

///|
/// Copy a file
pub async fn StorageBucket::copy(
  self : StorageBucket,
  from_path : String,
  to_path : String,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(from_path), @core.any(to_path)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("copy", args)
    .cast()
  promise.wait()
}

// ============================================================
// Realtime API
// ============================================================

///|
/// Create a realtime channel
pub fn SupabaseClient::channel(
  self : SupabaseClient,
  name : String,
  options? : @core.Any,
) -> RealtimeChannel {
  let args : Array[@core.Any] = [@core.any(name)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  self.as_any()._call("channel", args).cast()
}

///|
/// Subscribe to postgres changes
pub fn RealtimeChannel::on_postgres_changes(
  self : RealtimeChannel,
  event : String,
  schema : String,
  table? : String,
  filter? : String,
  callback : (@core.Any) -> Unit,
) -> RealtimeChannel {
  let config = @core.new_object()
  config["event"] = @core.any(event)
  config["schema"] = @core.any(schema)
  match table {
    Some(t) => config["table"] = @core.any(t)
    None => ()
  }
  match filter {
    Some(f) => config["filter"] = @core.any(f)
    None => ()
  }
  self
  .as_any()
  ._call("on", [@core.any("postgres_changes"), config, @js.from_fn1(callback)])
  .cast()
}

///|
/// Subscribe to broadcast messages
pub fn RealtimeChannel::on_broadcast(
  self : RealtimeChannel,
  event : String,
  callback : (@core.Any) -> Unit,
) -> RealtimeChannel {
  let config = @core.new_object()
  config["event"] = @core.any(event)
  self
  .as_any()
  ._call("on", [@core.any("broadcast"), config, @js.from_fn1(callback)])
  .cast()
}

///|
/// Subscribe to presence changes
pub fn RealtimeChannel::on_presence(
  self : RealtimeChannel,
  event : String,
  callback : (@core.Any) -> Unit,
) -> RealtimeChannel {
  let config = @core.new_object()
  config["event"] = @core.any(event)
  self
  .as_any()
  ._call("on", [@core.any("presence"), config, @js.from_fn1(callback)])
  .cast()
}

///|
/// Subscribe to the channel
pub fn RealtimeChannel::subscribe(
  self : RealtimeChannel,
  callback? : (@core.Any) -> Unit,
) -> RealtimeChannel {
  match callback {
    Some(cb) => self.as_any()._call("subscribe", [@js.from_fn1(cb)]).cast()
    None => self.as_any()._call("subscribe", []).cast()
  }
}

///|
/// Unsubscribe from the channel
pub async fn RealtimeChannel::unsubscribe(self : RealtimeChannel) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("unsubscribe", [])
    .cast()
  promise.wait()
}

///|
/// Send a broadcast message
pub async fn RealtimeChannel::send(
  self : RealtimeChannel,
  message : @core.Any,
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("send", [message])
    .cast()
  promise.wait()
}

///|
/// Track presence
pub async fn RealtimeChannel::track(
  self : RealtimeChannel,
  payload : @core.Any,
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("track", [payload])
    .cast()
  promise.wait()
}

///|
/// Untrack presence
pub async fn RealtimeChannel::untrack(self : RealtimeChannel) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("untrack", [])
    .cast()
  promise.wait()
}

///|
/// Remove a specific channel
pub async fn SupabaseClient::remove_channel(
  self : SupabaseClient,
  channel : RealtimeChannel,
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("removeChannel", [channel.as_any()])
    .cast()
  promise.wait()
}

///|
/// Remove all channels
pub async fn SupabaseClient::remove_all_channels(
  self : SupabaseClient,
) -> @core.Any {
  let promise : @js.Promise[@core.Any] = self
    .as_any()
    ._call("removeAllChannels", [])
    .cast()
  promise.wait()
}

// ============================================================
// Edge Functions
// ============================================================

///|
/// Invoke an edge function
pub async fn SupabaseClient::invoke(
  self : SupabaseClient,
  function_name : String,
  options? : @core.Any,
) -> @core.Any {
  let args : Array[@core.Any] = [@core.any(function_name)]
  match options {
    Some(opts) => args.push(opts)
    None => ()
  }
  let functions = self.as_any()["functions"]
  let promise : @js.Promise[@core.Any] = functions._call("invoke", args).cast()
  promise.wait()
}

// ============================================================
// RPC (Remote Procedure Call)
// ============================================================

///|
/// Call a Postgres function
pub async fn SupabaseClient::rpc(
  self : SupabaseClient,
  fn_name : String,
  args? : @core.Any,
  options? : @core.Any,
) -> PostgrestResponse {
  let call_args : Array[@core.Any] = [@core.any(fn_name)]
  match args {
    Some(a) => call_args.push(a)
    None => call_args.push(@core.new_object())
  }
  match options {
    Some(opts) => call_args.push(opts)
    None => ()
  }
  let builder = self.as_any()._call("rpc", call_args)
  let promise : @js.Promise[@core.Any] = builder.cast()
  promise.wait().cast()
}
