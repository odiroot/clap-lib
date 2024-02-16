module ext

import clap

pub const port_mono = unsafe { (&char(C.CLAP_PORT_MONO)).vstring() }
pub const port_stereo = unsafe { (&char(C.CLAP_PORT_STEREO)).vstring() }

// This port is the main audio input or output.
// There can be only one main input and main output.
// Main port must be at index 0.
pub const audio_port_is_main = u32(C.CLAP_AUDIO_PORT_IS_MAIN)
// This port can be used with 64 bits audio
pub const audio_port_supports_64bits = u32(C.CLAP_AUDIO_PORT_SUPPORTS_64BITS)
// 64 bits audio is preferred with this port
pub const audio_port_prefers_64bits = u32(C.CLAP_AUDIO_PORT_PREFERS_64BITS)
// This port must be used with the same sample size as all the other ports
// which have this flag. In other words if all ports have this flag then
// the plugin may either be used entirely with 64 bits audio or 32 bits audio,
// but it can't be mixed.
pub const audio_port_requires_common_sample_size = u32(C.CLAP_AUDIO_PORT_REQUIRES_COMMON_SAMPLE_SIZE)

@[typedef]
struct C.clap_audio_port_info_t {
pub mut:
	// id identifies a port and must be stable.
	// id may overlap between input and output ports.
	id   clap.Id
	name [clap.name_size]char // Displayable name.

	flags         u32
	channel_count u32
	// If null or empty then it is unspecified (arbitrary audio).
	// This field can be compared against:
	// - CLAP_PORT_MONO
	// - CLAP_PORT_STEREO
	// - CLAP_PORT_SURROUND (defined in the surround extension)
	// - CLAP_PORT_AMBISONIC (defined in the ambisonic extension)
	// - CLAP_PORT_CV (defined in the cv extension)
	// An extension can provide its own port type and way to inspect the channels.
	port_type &char
	// In-place processing: allow the host to use the same buffer for
	// input and output. If supported set the pair port id.
	// If not supported set to clap.invalid_id.
	in_place_pair clap.Id
}

pub type AudioPortInfo = C.clap_audio_port_info_t

@[typedef]
struct C.clap_plugin_audio_ports_t {
pub:
	// Number of ports, for either input or output
	// [main-thread]
	count fn (plugin &clap.Plugin, is_input bool) u32
	// Get info about an audio port.
	// Returns true on success and stores the result into info.
	// [main-thread]
	get fn (plugin &clap.Plugin, index u32, is_input bool, info &AudioPortInfo) bool
}

pub type PluginAudioPorts = C.clap_plugin_audio_ports_t

// The ports name did change, the host can scan them right away.
pub const audio_ports_rescan_names = u32(C.CLAP_AUDIO_PORTS_RESCAN_NAMES)
// [!active] The flags did change.
pub const audio_ports_rescan_flags = u32(C.CLAP_AUDIO_PORTS_RESCAN_FLAGS)
// [!active] The channel_count did change.
pub const audio_ports_channel_count = u32(C.CLAP_AUDIO_PORTS_RESCAN_CHANNEL_COUNT)
// [!active] The port type did change.
pub const audio_ports_rescan_port_type = u32(C.CLAP_AUDIO_PORTS_RESCAN_PORT_TYPE)
// [!active] The in-place pair did change, this requires.
pub const audio_ports_rescan_in_place_pair = u32(C.CLAP_AUDIO_PORTS_RESCAN_IN_PLACE_PAIR)
// [!active] The list of ports have changed: entries have been removed/added.
pub const audio_ports_rescan_list = u32(C.CLAP_AUDIO_PORTS_RESCAN_LIST)

@[typedef]
struct C.clap_host_audio_ports_t {
pub:
	// Checks if the host allows a plugin to change a given aspect of the
	// audio ports definition.
	// [main-thread]
	is_rescan_flag_supported fn (host &clap.Host, flag u32) bool
	// Rescan the full list of audio ports according to the flags.
	// It is illegal to ask the host to rescan with a flag that is not supported.
	// Certain flags require the plugin to be de-activated.
	// [main-thread]
	rescan fn (host &clap.Host, flags u32)
}

pub type HostAudioPorts = C.clap_host_audio_ports_t
