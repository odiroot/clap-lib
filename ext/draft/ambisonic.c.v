module draft

import clap

pub const port_ambisonic = unsafe { (&char(C.CLAP_PORT_AMBISONIC)).vstring() }

pub const ordering_fuma = u32(C.CLAP_AMBISONIC_ORDERING_FUMA)
pub const ordering_acn = u32(C.CLAP_AMBISONIC_ORDERING_ACN)

pub const normalization_maxn = u32(C.CLAP_AMBISONIC_NORMALIZATION_MAXN)
pub const normalization_sn3d = u32(C.CLAP_AMBISONIC_NORMALIZATION_SN3D)
pub const normalization_n3d = u32(C.CLAP_AMBISONIC_NORMALIZATION_N3D)
pub const normalization_sn2d = u32(C.CLAP_AMBISONIC_NORMALIZATION_SN2D)
pub const normalization_n2d = u32(C.CLAP_AMBISONIC_NORMALIZATION_N2D)

@[typedef]
struct C.clap_ambisonic_config_t {
pub:
	ordering      u32 // see ordering_* constants
	normalization u32 // see normalization_* constants
}

pub type AmbisonicConfig = C.clap_ambisonic_config_t

@[typedef]
struct C.clap_plugin_ambisonic_t {
pub:
	// Returns true if the given configuration is supported.
	// [main-thread]
	is_config_supported fn (plugin &clap.Plugin, config &AmbisonicConfig) bool

	// Returns true on success.
	// config_id: the configuration id, see clap_plugin_audio_ports_config.
	// If config_id is CLAP_INVALID_ID, then this function queries the current port info.
	// [main-thread]
	get_config fn (plugin &clap.Plugin, is_input bool, port_index u32, config &AmbisonicConfig) bool
}

pub type PluginAmbisonic = C.clap_plugin_ambisonic_t

@[typedef]
struct C.clap_host_ambisonic_t {
pub:
	// Informs the host that the info has changed.
	// The info can only change when the plugin is de-activated.
	// [main-thread]
	changed fn (host &clap.Host)
}

pub type HostAmbisonic = C.clap_host_ambisonic_t
