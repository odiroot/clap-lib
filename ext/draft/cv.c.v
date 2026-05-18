module draft

import clap

pub const port_cv = unsafe { (&char(C.CLAP_PORT_CV)).vstring_literal() }

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

pub type PluginCv = C.clap_plugin_cv_t

@[typedef]
struct C.clap_host_cv_t {
pub:
	// Informs the host that the channel types have changed.
	// The channel types can only change when the plugin is de-activated.
	// [main-thread, !active]
	changed fn (host &clap.Host)
}

pub type HostCv = C.clap_host_cv_t
