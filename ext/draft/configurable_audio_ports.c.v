module draft

import clap

@[typedef]
struct C.clap_audio_port_configuration_request_t {
pub:
	is_input      bool
	port_index    u32
	channel_count u32
	port_type     &char
	port_details  voidptr
}

pub type AudioPortConfigurationRequest = C.clap_audio_port_configuration_request_t

@[typedef]
struct C.clap_plugin_configurable_audio_ports_t {
pub:
	// [main-thread && !active]
	can_apply_configuration fn (plugin &clap.Plugin, requests &AudioPortConfigurationRequest, request_count u32) bool
	// [main-thread && !active]
	apply_configuration fn (plugin &clap.Plugin, requests &AudioPortConfigurationRequest, request_count u32) bool
}

pub type PluginConfigurableAudioPorts = C.clap_plugin_configurable_audio_ports_t
