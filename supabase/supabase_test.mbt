///|
/// Tests for supabase bindings
/// Note: These tests verify the API structure without actual Supabase connection
test "PostgrestResponse::data returns data field" {
  let obj = @core.new_object()
  let data_arr : Array[@core.Any] = []
  obj["data"] = @core.any(data_arr)
  obj["error"] = @core.null()
  obj["status"] = @core.any(200)
  obj["statusText"] = @core.any("OK")
  let response : @supabase.PostgrestResponse = obj.cast()
  let _ = response.data()

}

///|
test "PostgrestResponse::error returns None when null" {
  let obj = @core.new_object()
  let data_arr : Array[@core.Any] = []
  obj["data"] = @core.any(data_arr)
  obj["error"] = @core.null()
  obj["status"] = @core.any(200)
  obj["statusText"] = @core.any("OK")
  let response : @supabase.PostgrestResponse = obj.cast()
  inspect(response.error() is None, content="true")
}

///|
test "PostgrestResponse::error returns Some when error exists" {
  let obj = @core.new_object()
  obj["data"] = @core.null()
  let err = @core.new_object()
  err["message"] = @core.any("Not found")
  err["code"] = @core.any("404")
  obj["error"] = err
  obj["status"] = @core.any(404)
  obj["statusText"] = @core.any("Not Found")
  let response : @supabase.PostgrestResponse = obj.cast()
  inspect(response.error() is Some(_), content="true")
}

///|
test "PostgrestResponse::status returns status code" {
  let obj = @core.new_object()
  let data_arr : Array[@core.Any] = []
  obj["data"] = @core.any(data_arr)
  obj["error"] = @core.null()
  obj["status"] = @core.any(200)
  obj["statusText"] = @core.any("OK")
  let response : @supabase.PostgrestResponse = obj.cast()
  inspect(response.status(), content="200")
}

///|
test "PostgrestResponse::count returns count when present" {
  let obj = @core.new_object()
  let data_arr : Array[@core.Any] = []
  obj["data"] = @core.any(data_arr)
  obj["error"] = @core.null()
  obj["status"] = @core.any(200)
  obj["statusText"] = @core.any("OK")
  obj["count"] = @core.any(42)
  let response : @supabase.PostgrestResponse = obj.cast()
  inspect(response.count(), content="Some(42)")
}

///|
test "AuthResponse::user returns user data" {
  let obj = @core.new_object()
  let data = @core.new_object()
  let user = @core.new_object()
  user["id"] = @core.any("user-123")
  user["email"] = @core.any("test@example.com")
  data["user"] = user
  data["session"] = @core.null()
  obj["data"] = data
  obj["error"] = @core.null()
  let response : @supabase.AuthResponse = obj.cast()
  let u = response.user()
  inspect(u is Some(_), content="true")
}

///|
test "AuthResponse::error returns None when no error" {
  let obj = @core.new_object()
  let data = @core.new_object()
  data["user"] = @core.null()
  data["session"] = @core.null()
  obj["data"] = data
  obj["error"] = @core.null()
  let response : @supabase.AuthResponse = obj.cast()
  inspect(response.error() is None, content="true")
}

///|
test "SessionResponse::session returns session data" {
  let obj = @core.new_object()
  let data = @core.new_object()
  let session = @core.new_object()
  session["access_token"] = @core.any("token-123")
  session["refresh_token"] = @core.any("refresh-123")
  data["session"] = session
  obj["data"] = data
  obj["error"] = @core.null()
  let response : @supabase.SessionResponse = obj.cast()
  let s = response.session()
  inspect(s is Some(_), content="true")
}

///|
test "UserResponse::user returns user when present" {
  let obj = @core.new_object()
  let data = @core.new_object()
  let user = @core.new_object()
  user["id"] = @core.any("user-456")
  data["user"] = user
  obj["data"] = data
  obj["error"] = @core.null()
  let response : @supabase.UserResponse = obj.cast()
  inspect(response.user() is Some(_), content="true")
}

///|
test "UserResponse::user returns None when not present" {
  let obj = @core.new_object()
  let data = @core.new_object()
  data["user"] = @core.null()
  obj["data"] = data
  obj["error"] = @core.null()
  let response : @supabase.UserResponse = obj.cast()
  inspect(response.user() is None, content="true")
}
