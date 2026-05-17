module draft

import clap

@[typedef]
struct C.clap_plugin_extensible_audio_ports_t {
pub:
	// [main-thread && !is_active]
	add_port fn (plugin &clap.Plugin, is_input bool, channel_count u32, port_type &char, port_details voidptr) bool
	// [main-thread && !is_active]
	remove_port fn (plugin &clap.Plugin, is_input bool, index u32) bool
}

pub type PluginExtensibleAudioPorts = C.clap_plugin_extensible_audio_ports_t
