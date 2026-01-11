///|
test "is_tauri returns bool" {
  // In test environment, should return false
  let result = @tauri.is_tauri()
  inspect(result, content="false")
}

///|
test "convert_file_src" {
  let url = @tauri.convert_file_src("/path/to/file.png")
  // Should return asset protocol URL
  assert_true(url.contains("asset"))
}

///|
test "convert_file_src with custom protocol" {
  let url = @tauri.convert_file_src("/path/to/file.png", protocol="custom")
  assert_true(url.contains("custom"))
}

///|
test "permission_state_to_string" {
  inspect(
    @tauri.permission_state_to_string(@tauri.PermissionState::Granted),
    content="granted",
  )
  inspect(
    @tauri.permission_state_to_string(@tauri.PermissionState::Denied),
    content="denied",
  )
  inspect(
    @tauri.permission_state_to_string(@tauri.PermissionState::Prompt),
    content="prompt",
  )
  inspect(
    @tauri.permission_state_to_string(
      @tauri.PermissionState::PromptWithRationale,
    ),
    content="prompt-with-rationale",
  )
}

///|
test "permission_state_from_string" {
  assert_eq(
    @tauri.permission_state_to_string(
      @tauri.permission_state_from_string("granted"),
    ),
    "granted",
  )
  assert_eq(
    @tauri.permission_state_to_string(
      @tauri.permission_state_from_string("denied"),
    ),
    "denied",
  )
}

///|
test "theme_to_string" {
  inspect(@tauri.theme_to_string(@tauri.Theme::Light), content="light")
  inspect(@tauri.theme_to_string(@tauri.Theme::Dark), content="dark")
}

///|
test "bundle_type_to_string" {
  inspect(@tauri.bundle_type_to_string(@tauri.BundleType::App), content="app")
  inspect(
    @tauri.bundle_type_to_string(@tauri.BundleType::AppImage),
    content="appimage",
  )
  inspect(@tauri.bundle_type_to_string(@tauri.BundleType::Deb), content="deb")
  inspect(@tauri.bundle_type_to_string(@tauri.BundleType::Msi), content="msi")
  inspect(@tauri.bundle_type_to_string(@tauri.BundleType::Nsis), content="nsis")
  inspect(@tauri.bundle_type_to_string(@tauri.BundleType::Rpm), content="rpm")
}

///|
test "cursor_icon_to_string" {
  inspect(
    @tauri.cursor_icon_to_string(@tauri.CursorIcon::Default),
    content="default",
  )
  inspect(
    @tauri.cursor_icon_to_string(@tauri.CursorIcon::Crosshair),
    content="crosshair",
  )
  inspect(@tauri.cursor_icon_to_string(@tauri.CursorIcon::Hand), content="hand")
  inspect(@tauri.cursor_icon_to_string(@tauri.CursorIcon::Grab), content="grab")
  inspect(
    @tauri.cursor_icon_to_string(@tauri.CursorIcon::ZoomIn),
    content="zoomIn",
  )
}

///|
test "resize_direction_to_string" {
  inspect(
    @tauri.resize_direction_to_string(@tauri.ResizeDirection::North),
    content="North",
  )
  inspect(
    @tauri.resize_direction_to_string(@tauri.ResizeDirection::SouthEast),
    content="SouthEast",
  )
}

///|
test "delimiter and sep" {
  // Should return : or ; depending on platform
  let d = @tauri.delimiter()
  assert_true(d == ":" || d == ";")
  // Should return / or \\ depending on platform
  let s = @tauri.sep()
  assert_true(s == "/" || s == "\\")
}

///|
test "tauri event constants" {
  inspect(@tauri.TAURI_EVENT_WINDOW_FOCUS, content="tauri://focus")
  inspect(@tauri.TAURI_EVENT_WINDOW_BLUR, content="tauri://blur")
  inspect(
    @tauri.TAURI_EVENT_WINDOW_CLOSE_REQUESTED,
    content="tauri://close-requested",
  )
  inspect(@tauri.TAURI_EVENT_WINDOW_MOVED, content="tauri://move")
  inspect(@tauri.TAURI_EVENT_WINDOW_RESIZED, content="tauri://resize")
}
