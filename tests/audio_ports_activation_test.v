import clap.ext.draft

fn test_ext_audio_ports_activation_id_nonempty() {
	assert draft.ext_audio_ports_activation.len > 0
}

fn test_draft_extensions_contains_audio_ports_activation() {
	assert draft.ext_audio_ports_activation in draft.draft_extensions
}
