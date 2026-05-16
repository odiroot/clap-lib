import clap.ext.draft

fn test_ext_configurable_audio_ports_id_nonempty() {
	assert draft.ext_configurable_audio_ports.len > 0
}

fn test_draft_extensions_contains_configurable_audio_ports() {
	assert draft.ext_configurable_audio_ports in draft.draft_extensions
}

fn test_audio_port_configuration_request_defaults() {
	req := draft.AudioPortConfigurationRequest{}
	assert req.is_input == false
	assert req.port_index == 0
	assert req.channel_count == 0
	assert req.port_type == 0
	assert req.port_details == 0
}
