module draft

import clap

pub const state_context_for_duplicate = u32(C.CLAP_STATE_CONTEXT_FOR_DUPLICATE)
pub const state_context_for_preset = u32(C.CLAP_STATE_CONTEXT_FOR_PRESET)

@[typedef]
struct C.clap_plugin_state_context_t {
pub:
	// [main-thread]
	save fn (plugin &clap.Plugin, stream &clap.Ostream, context_type u32) bool
	// [main-thread]
	load fn (plugin &clap.Plugin, stream &clap.Istream, context_type u32) bool
}

pub type PluginStateContext = C.clap_plugin_state_context_t
