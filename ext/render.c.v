module ext

import clap

pub type PluginRenderMode = int

// Default setting, for "realtime" processing.
pub const render_realtime = C.CLAP_RENDER_REALTIME
// For processing without realtime pressure.
// The plugin may use more expensive algorithms for higher sound quality.
pub const render_offline = C.CLAP_RENDER_OFFLINE

// The render extension is used to let the plugin know if it has "realtime"
// pressure to process.
// If this information does not influence your rendering code, then don't
// implement this extension.
@[typedef]
struct C.clap_plugin_render_t {
pub:
	// Returns true if the plugin has a hard requirement to process in real-time.
	// [main-thread]
	has_hard_realtime_requirement fn (plugin &clap.Plugin) bool
	// Returns true if the rendering mode could be applied.
	// [main-thread]
	set fn (plugin &clap.Plugin, mode PluginRenderMode) bool
}

pub type PluginRender = C.clap_plugin_render_t
