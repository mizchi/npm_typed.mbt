///|
/// Tauri Window - Window management
/// https://v2.tauri.app/reference/javascript/api/namespacewindow/

///|
/// Window class
#external
pub type Window

///|
pub fn Window::as_any(self : Window) -> @core.Any = "%identity"

///|
extern "js" fn ffi_get_current_window() -> @core.Any =
  #| () => {
  #|   if (typeof window !== 'undefined' && window.__TAURI__) {
  #|     return window.__TAURI__.window.getCurrentWindow();
  #|   }
  #|   return null;
  #| }

///|
/// Get current window instance
pub fn get_current_window() -> Window {
  ffi_get_current_window().cast()
}

///|
extern "js" fn ffi_get_all_windows() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/window").then(m => m.getAllWindows())

///|
/// Get all window instances
pub async fn get_all_windows() -> Array[Window] {
  ffi_get_all_windows().wait().cast()
}

///|
extern "js" fn ffi_get_by_label(label : String) -> @js.Promise[@core.Any] =
  #| (label) => import("@tauri-apps/api/window").then(m => m.getByLabel(label))

///|
/// Get window by label
pub async fn get_by_label(label : String) -> Window? {
  let w = ffi_get_by_label(label).wait()
  if @core.is_nullish(w) {
    None
  } else {
    Some(w.cast())
  }
}

///|
extern "js" fn ffi_get_focused_window() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/window").then(m => m.getFocusedWindow())

///|
/// Get currently focused window
pub async fn get_focused_window() -> Window? {
  let w = ffi_get_focused_window().wait()
  if @core.is_nullish(w) {
    None
  } else {
    Some(w.cast())
  }
}

///|
/// Get window label
pub fn Window::label(self : Window) -> String {
  self.as_any()["label"].cast()
}

///|
extern "js" fn ffi_window_close(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.close()

///|
/// Close window
pub async fn Window::close(self : Window) -> Unit {
  ffi_window_close(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_center(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.center()

///|
/// Center window on screen
pub async fn Window::center(self : Window) -> Unit {
  ffi_window_center(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_hide(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.hide()

///|
/// Hide window
pub async fn Window::hide(self : Window) -> Unit {
  ffi_window_hide(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_show(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.show()

///|
/// Show window
pub async fn Window::show(self : Window) -> Unit {
  ffi_window_show(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_minimize(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.minimize()

///|
/// Minimize window
pub async fn Window::minimize(self : Window) -> Unit {
  ffi_window_minimize(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_maximize(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.maximize()

///|
/// Maximize window
pub async fn Window::maximize(self : Window) -> Unit {
  ffi_window_maximize(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_unmaximize(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.unmaximize()

///|
/// Unmaximize window
pub async fn Window::unmaximize(self : Window) -> Unit {
  ffi_window_unmaximize(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_toggle_maximize(
  w : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w) => w.toggleMaximize()

///|
/// Toggle window maximize state
pub async fn Window::toggle_maximize(self : Window) -> Unit {
  ffi_window_toggle_maximize(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_is_maximized(w : @core.Any) -> @js.Promise[Bool] =
  #| (w) => w.isMaximized()

///|
/// Check if window is maximized
pub async fn Window::is_maximized(self : Window) -> Bool {
  ffi_window_is_maximized(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_is_minimized(w : @core.Any) -> @js.Promise[Bool] =
  #| (w) => w.isMinimized()

///|
/// Check if window is minimized
pub async fn Window::is_minimized(self : Window) -> Bool {
  ffi_window_is_minimized(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_is_visible(w : @core.Any) -> @js.Promise[Bool] =
  #| (w) => w.isVisible()

///|
/// Check if window is visible
pub async fn Window::is_visible(self : Window) -> Bool {
  ffi_window_is_visible(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_is_focused(w : @core.Any) -> @js.Promise[Bool] =
  #| (w) => w.isFocused()

///|
/// Check if window is focused
pub async fn Window::is_focused(self : Window) -> Bool {
  ffi_window_is_focused(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_is_decorated(w : @core.Any) -> @js.Promise[Bool] =
  #| (w) => w.isDecorated()

///|
/// Check if window has decorations
pub async fn Window::is_decorated(self : Window) -> Bool {
  ffi_window_is_decorated(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_is_resizable(w : @core.Any) -> @js.Promise[Bool] =
  #| (w) => w.isResizable()

///|
/// Check if window is resizable
pub async fn Window::is_resizable(self : Window) -> Bool {
  ffi_window_is_resizable(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_is_fullscreen(w : @core.Any) -> @js.Promise[Bool] =
  #| (w) => w.isFullscreen()

///|
/// Check if window is fullscreen
pub async fn Window::is_fullscreen(self : Window) -> Bool {
  ffi_window_is_fullscreen(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_set_fullscreen(
  w : @core.Any,
  fullscreen : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, fs) => w.setFullscreen(fs)

///|
/// Set window fullscreen state
pub async fn Window::set_fullscreen(self : Window, fullscreen : Bool) -> Unit {
  ffi_window_set_fullscreen(self.as_any(), fullscreen).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_focus(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.setFocus()

///|
/// Focus window
pub async fn Window::set_focus(self : Window) -> Unit {
  ffi_window_set_focus(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_title(
  w : @core.Any,
  title : String,
) -> @js.Promise[@core.Any] =
  #| (w, title) => w.setTitle(title)

///|
/// Set window title
pub async fn Window::set_title(self : Window, title : String) -> Unit {
  ffi_window_set_title(self.as_any(), title).wait() |> ignore
}

///|
extern "js" fn ffi_window_title(w : @core.Any) -> @js.Promise[String] =
  #| (w) => w.title()

///|
/// Get window title
pub async fn Window::title(self : Window) -> String {
  ffi_window_title(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_set_decorations(
  w : @core.Any,
  decorations : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, d) => w.setDecorations(d)

///|
/// Set window decorations
pub async fn Window::set_decorations(self : Window, decorations : Bool) -> Unit {
  ffi_window_set_decorations(self.as_any(), decorations).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_resizable(
  w : @core.Any,
  resizable : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, r) => w.setResizable(r)

///|
/// Set window resizable
pub async fn Window::set_resizable(self : Window, resizable : Bool) -> Unit {
  ffi_window_set_resizable(self.as_any(), resizable).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_always_on_top(
  w : @core.Any,
  always_on_top : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, a) => w.setAlwaysOnTop(a)

///|
/// Set window always on top
pub async fn Window::set_always_on_top(
  self : Window,
  always_on_top : Bool,
) -> Unit {
  ffi_window_set_always_on_top(self.as_any(), always_on_top).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_always_on_bottom(
  w : @core.Any,
  always_on_bottom : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, a) => w.setAlwaysOnBottom(a)

///|
/// Set window always on bottom
pub async fn Window::set_always_on_bottom(
  self : Window,
  always_on_bottom : Bool,
) -> Unit {
  ffi_window_set_always_on_bottom(self.as_any(), always_on_bottom).wait()
  |> ignore
}

///|
extern "js" fn ffi_window_inner_position(
  w : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w) => w.innerPosition()

///|
/// Get window inner position
pub async fn Window::inner_position(self : Window) -> @dpi.PhysicalPosition {
  let pos = ffi_window_inner_position(self.as_any()).wait()
  { x: pos["x"].cast(), y: pos["y"].cast() }
}

///|
extern "js" fn ffi_window_outer_position(
  w : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w) => w.outerPosition()

///|
/// Get window outer position
pub async fn Window::outer_position(self : Window) -> @dpi.PhysicalPosition {
  let pos = ffi_window_outer_position(self.as_any()).wait()
  { x: pos["x"].cast(), y: pos["y"].cast() }
}

///|
extern "js" fn ffi_window_set_position(
  w : @core.Any,
  pos : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w, pos) => w.setPosition(pos)

///|
/// Set window position
pub async fn Window::set_position(
  self : Window,
  position : @dpi.Position,
) -> Unit {
  ffi_window_set_position(self.as_any(), position.to_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_inner_size(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.innerSize()

///|
/// Get window inner size
pub async fn Window::inner_size(self : Window) -> @dpi.PhysicalSize {
  let size = ffi_window_inner_size(self.as_any()).wait()
  { width: size["width"].cast(), height: size["height"].cast() }
}

///|
extern "js" fn ffi_window_outer_size(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.outerSize()

///|
/// Get window outer size
pub async fn Window::outer_size(self : Window) -> @dpi.PhysicalSize {
  let size = ffi_window_outer_size(self.as_any()).wait()
  { width: size["width"].cast(), height: size["height"].cast() }
}

///|
extern "js" fn ffi_window_set_size(
  w : @core.Any,
  size : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w, size) => w.setSize(size)

///|
/// Set window size
pub async fn Window::set_size(self : Window, size : @dpi.Size) -> Unit {
  ffi_window_set_size(self.as_any(), size.to_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_min_size(
  w : @core.Any,
  size : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w, size) => w.setMinSize(size)

///|
/// Set window minimum size
pub async fn Window::set_min_size(self : Window, size? : @dpi.Size) -> Unit {
  let s : @core.Any = match size {
    Some(s) => s.to_any()
    None => @core.null()
  }
  ffi_window_set_min_size(self.as_any(), s).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_max_size(
  w : @core.Any,
  size : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w, size) => w.setMaxSize(size)

///|
/// Set window maximum size
pub async fn Window::set_max_size(self : Window, size? : @dpi.Size) -> Unit {
  let s : @core.Any = match size {
    Some(s) => s.to_any()
    None => @core.null()
  }
  ffi_window_set_max_size(self.as_any(), s).wait() |> ignore
}

///|
extern "js" fn ffi_window_scale_factor(w : @core.Any) -> @js.Promise[Double] =
  #| (w) => w.scaleFactor()

///|
/// Get window scale factor
pub async fn Window::scale_factor(self : Window) -> Double {
  ffi_window_scale_factor(self.as_any()).wait()
}

///|
extern "js" fn ffi_window_theme(w : @core.Any) -> @js.Promise[@core.Any] =
  #| (w) => w.theme()

///|
/// Get window theme
pub async fn Window::theme(self : Window) -> Theme? {
  let t = ffi_window_theme(self.as_any()).wait()
  if @core.is_nullish(t) {
    None
  } else {
    Some(theme_from_string(t.cast()))
  }
}

///|
/// Monitor information
#external
pub type Monitor

///|
pub fn Monitor::as_any(self : Monitor) -> @core.Any = "%identity"

///|
/// Get monitor name
pub fn Monitor::name(self : Monitor) -> String? {
  let n = self.as_any()["name"]
  if @core.is_nullish(n) {
    None
  } else {
    Some(n.cast())
  }
}

///|
/// Get monitor size
pub fn Monitor::size(self : Monitor) -> @dpi.PhysicalSize {
  let s = self.as_any()["size"]
  { width: s["width"].cast(), height: s["height"].cast() }
}

///|
/// Get monitor position
pub fn Monitor::position(self : Monitor) -> @dpi.PhysicalPosition {
  let p = self.as_any()["position"]
  { x: p["x"].cast(), y: p["y"].cast() }
}

///|
/// Get monitor scale factor
pub fn Monitor::scale_factor(self : Monitor) -> Double {
  self.as_any()["scaleFactor"].cast()
}

///|
extern "js" fn ffi_available_monitors() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/window").then(m => m.availableMonitors())

///|
/// Get all available monitors
pub async fn available_monitors() -> Array[Monitor] {
  ffi_available_monitors().wait().cast()
}

///|
extern "js" fn ffi_current_monitor() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/window").then(m => m.currentMonitor())

///|
/// Get current monitor
pub async fn current_monitor() -> Monitor? {
  let m = ffi_current_monitor().wait()
  if @core.is_nullish(m) {
    None
  } else {
    Some(m.cast())
  }
}

///|
extern "js" fn ffi_primary_monitor() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/window").then(m => m.primaryMonitor())

///|
/// Get primary monitor
pub async fn primary_monitor() -> Monitor? {
  let m = ffi_primary_monitor().wait()
  if @core.is_nullish(m) {
    None
  } else {
    Some(m.cast())
  }
}

///|
extern "js" fn ffi_cursor_position() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/window").then(m => m.cursorPosition())

///|
/// Get cursor position
pub async fn cursor_position() -> @dpi.PhysicalPosition {
  let pos = ffi_cursor_position().wait()
  { x: pos["x"].cast(), y: pos["y"].cast() }
}

///|
/// Cursor icon types
pub(all) enum CursorIcon {
  Default
  Crosshair
  Hand
  Arrow
  Move
  Text
  Wait
  Help
  Progress
  NotAllowed
  ContextMenu
  Cell
  VerticalText
  Alias
  Copy
  NoDrop
  Grab
  Grabbing
  AllScroll
  ZoomIn
  ZoomOut
  EResize
  NResize
  NeResize
  NwResize
  SResize
  SeResize
  SwResize
  WResize
  EwResize
  NsResize
  NeswResize
  NwseResize
  ColResize
  RowResize
}

///|
pub fn cursor_icon_to_string(icon : CursorIcon) -> String {
  match icon {
    Default => "default"
    Crosshair => "crosshair"
    Hand => "hand"
    Arrow => "arrow"
    Move => "move"
    Text => "text"
    Wait => "wait"
    Help => "help"
    Progress => "progress"
    NotAllowed => "notAllowed"
    ContextMenu => "contextMenu"
    Cell => "cell"
    VerticalText => "verticalText"
    Alias => "alias"
    Copy => "copy"
    NoDrop => "noDrop"
    Grab => "grab"
    Grabbing => "grabbing"
    AllScroll => "allScroll"
    ZoomIn => "zoomIn"
    ZoomOut => "zoomOut"
    EResize => "eResize"
    NResize => "nResize"
    NeResize => "neResize"
    NwResize => "nwResize"
    SResize => "sResize"
    SeResize => "seResize"
    SwResize => "swResize"
    WResize => "wResize"
    EwResize => "ewResize"
    NsResize => "nsResize"
    NeswResize => "neswResize"
    NwseResize => "nwseResize"
    ColResize => "colResize"
    RowResize => "rowResize"
  }
}

///|
extern "js" fn ffi_window_set_cursor_icon(
  w : @core.Any,
  icon : String,
) -> @js.Promise[@core.Any] =
  #| (w, icon) => w.setCursorIcon(icon)

///|
/// Set cursor icon
pub async fn Window::set_cursor_icon(self : Window, icon : CursorIcon) -> Unit {
  ffi_window_set_cursor_icon(self.as_any(), cursor_icon_to_string(icon)).wait()
  |> ignore
}

///|
extern "js" fn ffi_window_set_cursor_visible(
  w : @core.Any,
  visible : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, v) => w.setCursorVisible(v)

///|
/// Set cursor visibility
pub async fn Window::set_cursor_visible(self : Window, visible : Bool) -> Unit {
  ffi_window_set_cursor_visible(self.as_any(), visible).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_cursor_position(
  w : @core.Any,
  pos : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w, pos) => w.setCursorPosition(pos)

///|
/// Set cursor position
pub async fn Window::set_cursor_position(
  self : Window,
  position : @dpi.Position,
) -> Unit {
  ffi_window_set_cursor_position(self.as_any(), position.to_any()).wait()
  |> ignore
}

///|
extern "js" fn ffi_window_set_cursor_grab(
  w : @core.Any,
  grab : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, g) => w.setCursorGrab(g)

///|
/// Set cursor grab
pub async fn Window::set_cursor_grab(self : Window, grab : Bool) -> Unit {
  ffi_window_set_cursor_grab(self.as_any(), grab).wait() |> ignore
}

///|
extern "js" fn ffi_window_set_ignore_cursor_events(
  w : @core.Any,
  ignore : Bool,
) -> @js.Promise[@core.Any] =
  #| (w, i) => w.setIgnoreCursorEvents(i)

///|
/// Set ignore cursor events
pub async fn Window::set_ignore_cursor_events(
  self : Window,
  should_ignore : Bool,
) -> Unit {
  ffi_window_set_ignore_cursor_events(self.as_any(), should_ignore).wait()
  |> ignore
}

///|
extern "js" fn ffi_window_start_dragging(
  w : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (w) => w.startDragging()

///|
/// Start dragging window
pub async fn Window::start_dragging(self : Window) -> Unit {
  ffi_window_start_dragging(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_window_start_resize_dragging(
  w : @core.Any,
  direction : String,
) -> @js.Promise[@core.Any] =
  #| (w, d) => w.startResizeDragging(d)

///|
/// Resize direction
pub(all) enum ResizeDirection {
  North
  South
  East
  West
  NorthEast
  NorthWest
  SouthEast
  SouthWest
}

///|
pub fn resize_direction_to_string(dir : ResizeDirection) -> String {
  match dir {
    North => "North"
    South => "South"
    East => "East"
    West => "West"
    NorthEast => "NorthEast"
    NorthWest => "NorthWest"
    SouthEast => "SouthEast"
    SouthWest => "SouthWest"
  }
}

///|
/// Start resize dragging
pub async fn Window::start_resize_dragging(
  self : Window,
  direction : ResizeDirection,
) -> Unit {
  ffi_window_start_resize_dragging(
    self.as_any(),
    resize_direction_to_string(direction),
  ).wait()
  |> ignore
}
