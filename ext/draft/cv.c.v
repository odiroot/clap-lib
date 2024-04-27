module draft

import clap

// This extension can be used to specify the CV channel type used by the plugin.
pub const port_cv = unsafe { (&char(C.CLAP_PORT_CV)).vstring() }

pub const cv_value = u32(C.CLAP_CV_VALUE)
pub const cv_gate = u32(C.CLAP_CV_GATE)
pub const cv_pitch = u32(C.CLAP_CV_PITCH)

@[typedef]
struct C.clap_plugin_cv_t {
pub:
	// Returns true on success.
	// [main-thread]
	get_channel_type fn (plugin &clap.Plugin, is_input bool, port_index u32, channel_index u32, channel_type &u32) bool
}

pub type PluginCV = C.clap_plugin_cv_t
