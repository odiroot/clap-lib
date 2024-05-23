module ext

import clap

// This extension let the plugin provide port configurations presets.
// For example mono, stereo, surround, ambisonic.
// After the plugin initialization, the host may scan the list of configurations
// and eventually select one that fits the plugin context. The host can only
// select a configuration if the plugin is deactivated.
// A configuration is a very simple description of the audio ports:
// - it describes the main input and output ports,
// - it has a name that can be displayed to the user.

// To inquire the exact bus layout, the plugin implements the
// clap_plugin_audio_ports_config_info_t extension where all busses can be
// retrieved in the same way as in the audio-port extension.

pub const ext_audio_ports_config_info = unsafe { (&char(C.CLAP_EXT_AUDIO_PORTS_CONFIG_INFO)).vstring() }

// Minimalistic description of ports configuration.
@[typedef]
struct C.clap_audio_ports_config_t {
pub:
	id   clap.Id
	name clap.Name

	input_port_count  u32
	output_port_count u32
	// Main input info.
	has_main_input           bool
	main_input_channel_count u32
	main_input_port_type     &char
	// Main output info.
	has_main_output           bool
	main_output_channel_count u32
	main_output_port_type     &char
}

pub type AudioPortsConfig = C.clap_audio_ports_config_t

// The audio ports config scan has to be done while the plugin is deactivated.
@[typedef]
struct C.clap_plugin_audio_ports_config_t {
pub:
	// Gets the number of available configurations.
	// [main-thread]
	count fn (plugin &clap.Plugin) u32
	// Gets information about a configuration.
	// Returns true on success and stores the result into config.
	// [main-thread]
	get fn (plugin &clap.Plugin, index u32, config &AudioPortsConfig) bool
	// Selects the configuration designated by id.
	// Returns true if the configuration could be applied.
	// Once applied the host should scan again the audio ports.
	// [main-thread & plugin-deactivated]
	@select fn (plugin &clap.Plugin, config_id clap.Id) bool
}

pub type PluginAudioPortsConfig = C.clap_plugin_audio_ports_config_t

@[typedef]
struct C.clap_plugin_audio_ports_config_info_t {
pub:
	// Gets the id of the currently selected config, or CLAP_INVALID_ID
	// if the current port layout isn't part of the config list.
	// [main-thread]
	current_config fn (plugin &clap.Plugin) clap.Id
	// Get info about an audio port, for a given config_id.
	// This is analogous to clap_plugin_audio_ports.get().
	// Returns true on success and stores the result into info.
	// [main-thread]
	get fn (plugin &clap.Plugin, config_id clap.Id, port_index u32, is_input bool, info &AudioPortInfo) bool
}

pub type PluginAudioPortsConfigInfo = C.clap_plugin_audio_ports_config_info_t

@[typedef]
struct C.clap_host_audio_ports_config_t {
pub:
	// Rescan the full list of configs.
	// [main-thread]
	rescan fn (host &clap.Host)
}

pub type HostAudioPortsConfig = C.clap_host_audio_ports_config_t
