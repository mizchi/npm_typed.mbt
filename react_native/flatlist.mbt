///| FlatList component for React Native
/// https://reactnative.dev/docs/flatlist

// ============================================================================
// FlatList Component
// ============================================================================

///|
/// ListRenderItem type for FlatList
pub struct ListRenderItemInfo[T] {
  item : T
  index : Int
  separators : Separators
}

///|
/// Separators object for FlatList
#external
pub type Separators

///|
pub fn Separators::as_any(self : Separators) -> @core.Any = "%identity"

///|
extern "js" fn ffi_separators_highlight(sep : Separators) -> Unit =
  #| (sep) => sep.highlight()

///|
extern "js" fn ffi_separators_unhighlight(sep : Separators) -> Unit =
  #| (sep) => sep.unhighlight()

///|
extern "js" fn ffi_separators_update_props(
  sep : Separators,
  select : String,
  new_props : @core.Any,
) -> Unit =
  #| (sep, select, props) => sep.updateProps(select, props)

///|
/// Highlight the separator
pub fn Separators::highlight(self : Separators) -> Unit {
  ffi_separators_highlight(self)
}

///|
/// Unhighlight the separator
pub fn Separators::unhighlight(self : Separators) -> Unit {
  ffi_separators_unhighlight(self)
}

///|
/// Update props of the separator
pub fn Separators::update_props(
  self : Separators,
  select : String,
  new_props : @core.Any,
) -> Unit {
  ffi_separators_update_props(self, select, new_props)
}

///|
fn[T] ListRenderItemInfo::from_any(any : @core.Any) -> ListRenderItemInfo[T] {
  {
    item: any["item"].cast(),
    index: any["index"].cast(),
    separators: any["separators"].cast(),
  }
}

///|
/// FlatList - A performant interface for rendering flat lists
pub fn[T] flat_list(
  data~ : Array[T],
  render_item~ : (ListRenderItemInfo[T]) -> @react.Element,
  key_extractor? : ((T, Int) -> String)? = None,
  style? : StyleProp? = None,
  content_container_style? : StyleProp? = None,
  horizontal? : Bool? = None,
  inverted? : Bool? = None,
  num_columns? : Int? = None,
  initial_num_to_render? : Int? = None,
  max_to_render_per_batch? : Int? = None,
  window_size? : Int? = None,
  remove_clipped_subviews? : Bool? = None,
  scroll_enabled? : Bool? = None,
  shows_vertical_scroll_indicator? : Bool? = None,
  shows_horizontal_scroll_indicator? : Bool? = None,
  bounces? : Bool? = None,
  on_end_reached? : (() -> Unit)? = None,
  on_end_reached_threshold? : Double? = None,
  on_refresh? : (() -> Unit)? = None,
  refreshing? : Bool? = None,
  on_scroll? : ((ScrollEvent) -> Unit)? = None,
  list_header_component? : @react.Element? = None,
  list_footer_component? : @react.Element? = None,
  list_empty_component? : @react.Element? = None,
  item_separator_component? : (() -> @react.Element)? = None,
  extra_data? : @core.Any? = None,
  get_item_layout? : ((Array[T], Int) -> ItemLayout)? = None,
  keyboard_should_persist_taps? : String? = None,
  keyboard_dismiss_mode? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("data", @core.any(data))

  // Wrap render_item
  let render_item_fn : (@core.Any) -> @react.Element = fn(info) {
    render_item(ListRenderItemInfo::from_any(info))
  }
  props._set("renderItem", @js.from_fn1(render_item_fn))
  if key_extractor is Some(f) {
    let key_fn : (@core.Any, @core.Any) -> String = fn(item, index) {
      f(item.cast(), index.cast())
    }
    props._set("keyExtractor", @js.from_fn2(key_fn))
  }
  set_style(props, style)
  set_test_id(props, test_id)
  if content_container_style is Some(s) {
    props._set("contentContainerStyle", s.as_any())
  }
  if horizontal is Some(v) {
    props._set("horizontal", @core.any(v))
  }
  if inverted is Some(v) {
    props._set("inverted", @core.any(v))
  }
  if num_columns is Some(v) {
    props._set("numColumns", @core.any(v))
  }
  if initial_num_to_render is Some(v) {
    props._set("initialNumToRender", @core.any(v))
  }
  if max_to_render_per_batch is Some(v) {
    props._set("maxToRenderPerBatch", @core.any(v))
  }
  if window_size is Some(v) {
    props._set("windowSize", @core.any(v))
  }
  if remove_clipped_subviews is Some(v) {
    props._set("removeClippedSubviews", @core.any(v))
  }
  if scroll_enabled is Some(v) {
    props._set("scrollEnabled", @core.any(v))
  }
  if shows_vertical_scroll_indicator is Some(v) {
    props._set("showsVerticalScrollIndicator", @core.any(v))
  }
  if shows_horizontal_scroll_indicator is Some(v) {
    props._set("showsHorizontalScrollIndicator", @core.any(v))
  }
  if bounces is Some(v) {
    props._set("bounces", @core.any(v))
  }
  if on_end_reached is Some(f) {
    props._set("onEndReached", @js.from_fn0(f))
  }
  if on_end_reached_threshold is Some(v) {
    props._set("onEndReachedThreshold", @core.any(v))
  }
  if on_refresh is Some(f) {
    props._set("onRefresh", @js.from_fn0(f))
  }
  if refreshing is Some(v) {
    props._set("refreshing", @core.any(v))
  }
  if on_scroll is Some(f) {
    props._set("onScroll", @js.from_fn1(f))
  }
  if list_header_component is Some(c) {
    props._set("ListHeaderComponent", c.as_any())
  }
  if list_footer_component is Some(c) {
    props._set("ListFooterComponent", c.as_any())
  }
  if list_empty_component is Some(c) {
    props._set("ListEmptyComponent", c.as_any())
  }
  if item_separator_component is Some(f) {
    props._set("ItemSeparatorComponent", @js.from_fn0(f))
  }
  if extra_data is Some(v) {
    props._set("extraData", v)
  }
  if get_item_layout is Some(f) {
    let layout_fn : (@core.Any, @core.Any) -> @core.Any = fn(data_arr, index) {
      let layout = f(data_arr.cast(), index.cast())
      let obj = @core.new_object()
      obj._set("length", @core.any(layout.length))
      obj._set("offset", @core.any(layout.offset))
      obj._set("index", @core.any(layout.index))
      obj
    }
    props._set("getItemLayout", @js.from_fn2(layout_fn))
  }
  if keyboard_should_persist_taps is Some(v) {
    props._set("keyboardShouldPersistTaps", @core.any(v))
  }
  if keyboard_dismiss_mode is Some(v) {
    props._set("keyboardDismissMode", @core.any(v))
  }
  create_element(ffi_flat_list(), props, key~)
}

///|
/// ItemLayout for getItemLayout optimization
pub struct ItemLayout {
  length : Double
  offset : Double
  index : Int
}

///|
pub fn ItemLayout::new(
  length~ : Double,
  offset~ : Double,
  index~ : Int,
) -> ItemLayout {
  { length, offset, index }
}

// ============================================================================
// SectionList Component
// ============================================================================

///|
/// Section data for SectionList
pub struct Section[T] {
  title : String
  data : Array[T]
}

///|
pub fn[T] Section::new(title~ : String, data~ : Array[T]) -> Section[T] {
  { title, data }
}

///|
pub fn[T] Section::to_any(self : Section[T]) -> @core.Any {
  let obj = @core.new_object()
  obj._set("title", @core.any(self.title))
  obj._set("data", @core.any(self.data))
  obj
}

///|
/// SectionListRenderItemInfo
pub struct SectionListRenderItemInfo[T] {
  item : T
  index : Int
  section : @core.Any
  separators : Separators
}

///|
fn[T] SectionListRenderItemInfo::from_any(
  any : @core.Any,
) -> SectionListRenderItemInfo[T] {
  {
    item: any["item"].cast(),
    index: any["index"].cast(),
    section: any["section"],
    separators: any["separators"].cast(),
  }
}

///|
/// SectionList - A performant interface for rendering sectioned lists
pub fn[T] section_list(
  sections~ : Array[Section[T]],
  render_item~ : (SectionListRenderItemInfo[T]) -> @react.Element,
  render_section_header? : ((Section[T]) -> @react.Element)? = None,
  render_section_footer? : ((Section[T]) -> @react.Element)? = None,
  key_extractor? : ((T, Int) -> String)? = None,
  style? : StyleProp? = None,
  content_container_style? : StyleProp? = None,
  stickySectionHeadersEnabled? : Bool? = None,
  inverted? : Bool? = None,
  initial_num_to_render? : Int? = None,
  on_end_reached? : (() -> Unit)? = None,
  on_end_reached_threshold? : Double? = None,
  on_refresh? : (() -> Unit)? = None,
  refreshing? : Bool? = None,
  list_header_component? : @react.Element? = None,
  list_footer_component? : @react.Element? = None,
  list_empty_component? : @react.Element? = None,
  item_separator_component? : (() -> @react.Element)? = None,
  section_separator_component? : (() -> @react.Element)? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("sections", @core.any(sections.map(Section::to_any)))

  // Wrap render_item
  let render_item_fn : (@core.Any) -> @react.Element = fn(info) {
    render_item(SectionListRenderItemInfo::from_any(info))
  }
  props._set("renderItem", @js.from_fn1(render_item_fn))
  if render_section_header is Some(f) {
    let header_fn : (@core.Any) -> @react.Element = fn(section_info) {
      let section : Section[T] = {
        title: section_info["section"]["title"].cast(),
        data: section_info["section"]["data"].cast(),
      }
      f(section)
    }
    props._set("renderSectionHeader", @js.from_fn1(header_fn))
  }
  if render_section_footer is Some(f) {
    let footer_fn : (@core.Any) -> @react.Element = fn(section_info) {
      let section : Section[T] = {
        title: section_info["section"]["title"].cast(),
        data: section_info["section"]["data"].cast(),
      }
      f(section)
    }
    props._set("renderSectionFooter", @js.from_fn1(footer_fn))
  }
  if key_extractor is Some(f) {
    let key_fn : (@core.Any, @core.Any) -> String = fn(item, index) {
      f(item.cast(), index.cast())
    }
    props._set("keyExtractor", @js.from_fn2(key_fn))
  }
  set_style(props, style)
  set_test_id(props, test_id)
  if content_container_style is Some(s) {
    props._set("contentContainerStyle", s.as_any())
  }
  if stickySectionHeadersEnabled is Some(v) {
    props._set("stickySectionHeadersEnabled", @core.any(v))
  }
  if inverted is Some(v) {
    props._set("inverted", @core.any(v))
  }
  if initial_num_to_render is Some(v) {
    props._set("initialNumToRender", @core.any(v))
  }
  if on_end_reached is Some(f) {
    props._set("onEndReached", @js.from_fn0(f))
  }
  if on_end_reached_threshold is Some(v) {
    props._set("onEndReachedThreshold", @core.any(v))
  }
  if on_refresh is Some(f) {
    props._set("onRefresh", @js.from_fn0(f))
  }
  if refreshing is Some(v) {
    props._set("refreshing", @core.any(v))
  }
  if list_header_component is Some(c) {
    props._set("ListHeaderComponent", c.as_any())
  }
  if list_footer_component is Some(c) {
    props._set("ListFooterComponent", c.as_any())
  }
  if list_empty_component is Some(c) {
    props._set("ListEmptyComponent", c.as_any())
  }
  if item_separator_component is Some(f) {
    props._set("ItemSeparatorComponent", @js.from_fn0(f))
  }
  if section_separator_component is Some(f) {
    props._set("SectionSeparatorComponent", @js.from_fn0(f))
  }
  create_element(ffi_section_list(), props, key~)
}
