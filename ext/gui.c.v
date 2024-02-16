module ext

import clap

// This extension defines how the plugin will present its GUI.

// There are two approaches:
// 1. the plugin creates a window and embeds it into the host's window
// 2. the plugin creates a floating window
// Embedding the window gives more control to the host, and feels more integrated.
// Floating window are sometimes the only option due to technical limitations.

// Uses physical size.
// Embed using https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setparent
pub const window_api_win32 = unsafe { (&char(C.CLAP_WINDOW_API_WIN32)).vstring() }
// Uses logical size, don't call clap_plugin_gui.set_scale()
pub const window_api_cocoa = unsafe { (&char(C.CLAP_WINDOW_API_COCOA)).vstring() }
// Uses physical size
// Embed using https://specifications.freedesktop.org/xembed-spec/xembed-spec-latest.html
pub const window_api_x11 = unsafe { (&char(C.CLAP_WINDOW_API_X11)).vstring() }
// Uses physical size.
// Embed is currently not supported, use floating windows.
pub const window_api_wayland = unsafe { (&char(C.CLAP_WINDOW_API_WAYLAND)).vstring() }

type HWnd = voidptr
type NSView = voidptr
type XWnd = u32

// Represent a window reference.
@[typedef]
struct C.clap_window_t {
pub:
	api &char // One of window_ap_* above.
	// union {
	cocoa NSView
	x11   XWnd
	win32 HWnd
	ptr   voidptr // For anything defined outside of clap.
	// }
}

pub type Window = C.clap_window_t

// Information to improve window resizing when initiated by the host or
// window manager.
@[typedef]
struct C.clap_gui_resize_hints_t {
pub:
	can_resize_horizontally bool
	can_resize_vertically   bool
	// Only if can resize horizontally and vertically.
	preserve_aspect_ratio bool
	aspect_ratio_width    u32
	aspect_ratio_height   u32
}

pub type GUIResizeHints = C.clap_gui_resize_hints_t

// Size (width, height) is in pixels; the corresponding windowing system
// extension is responsible for defining if it is physical pixels or logical
// pixels.
@[typedef]
struct C.clap_plugin_gui_t {
pub:
	// Returns true if the requested GUI api is supported.
	// [main-thread]
	is_api_supported fn (plugin &clap.Plugin, api &char, is_floating bool) bool
	// Returns true if the plugin has a preferred api.
	// [main-thread]
	// Note: voidptr is &&char in original but used in a weird way.
	get_preferred_api fn (plugin &clap.Plugin, api voidptr, is_floating &bool) bool
	// Create and allocate all resources necessary for the GUI.
	// If is_floating is true, then the window will not be managed by the host.
	// The plugin can set its window to stays above the parent window.
	// api may be null or blank for floating window.
	// If is_floating is false, then the plugin has to embed its window into
	// the parent window.
	// Returns true if the GUI is successfully created.
	// [main-thread]
	create fn (plugin &clap.Plugin, api &char, is_floating bool) bool
	// Free all resources associated with the GUI.
	// [main-thread]
	destroy fn (plugin &clap.Plugin)
	// Set the absolute GUI scaling factor, and override any OS info.
	// Should not be used if the windowing api relies upon logical pixels.
	// If the plugin prefers to work out the scaling factor itself by querying
	// the OS directly, then ignore the call.
	// scale = 2 means 200% scaling.
	// Returns true if the scaling could be applied.
	// Returns false if the call was ignored, or the scaling could not be applied.
	// [main-thread]
	set_scale fn (plugin &clap.Plugin, scale f64) bool
	// Get the current size of the plugin UI.
	// clap_plugin_gui.create() must have been called prior to asking the size.
	// Returns true if the plugin could get the size.
	// [main-thread]
	get_size fn (plugin &clap.Plugin, width &u32, height &u32) bool
	// Returns true if the window is resizeable (mouse drag).
	// [main-thread & !floating]
	can_resize fn (plugin &clap.Plugin) bool
	// Returns true if the plugin can provide hints on how to resize the window.
	// [main-thread & !floating]
	get_resize_hints fn (plugin &clap.Plugin, hints &GUIResizeHints) bool
	// If the plugin GUI is resizable, then the plugin will calculate the
	// closest usable size which fits in the given size.
	// This method does not change the size.
	// Returns true if the plugin could adjust the given size.
	// [main-thread & !floating]
	adjust_size fn (plugin &clap.Plugin, width &u32, height &u32) bool
	// Sets the window size.
	// Returns true if the plugin could resize its window to the given size.
	// [main-thread & !floating]
	set_size fn (plugin &clap.Plugin, width &u32, height &u32) bool
	// Embeds the plugin window into the given window.
	// Returns true on success.
	// [main-thread & !floating]
	set_parent fn (plugin &clap.Plugin, window &Window) bool
	// Set the plugin floating window to stay above the given window.
	// Returns true on success.
	// [main-thread & floating]
	set_transient fn (plugin &clap.Plugin, window &Window) bool
	// Suggests a window title. Only for floating windows.
	// [main-thread & floating]
	suggest_title fn (plugin &clap.Plugin, title &char)
	// Show the window.
	// Returns true on success.
	// [main-thread]
	show fn (plugin &clap.Plugin) bool
	// Hide the window, this method does not free the resources, it just hides
	// the window content. Yet it may be a good idea to stop painting timers.
	// Returns true on success.
	// [main-thread]
	hide fn (plugin &clap.Plugin) bool
}

pub type PluginGUI = C.clap_plugin_gui_t
