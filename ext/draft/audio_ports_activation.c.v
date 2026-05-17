module draft

import clap

@[typedef]
struct C.clap_plugin_audio_ports_activation_t {
pub:
	// Returns true if the plugin supports activation/deactivation while processing.
	// [main-thread]
	can_activate_while_processing fn (plugin &clap.Plugin) bool

	// Activate the given port.
	// [active ? audio-thread : main-thread]
	set_active fn (plugin &clap.Plugin, is_input bool, port_index u32, is_active bool, sample_size u32) bool
}

pub type PluginAudioPortsActivation = C.clap_plugin_audio_ports_activation_t
