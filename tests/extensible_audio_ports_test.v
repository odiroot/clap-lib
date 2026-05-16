import clap.ext.draft

fn test_ext_extensible_audio_ports_id_nonempty() {
	assert draft.ext_extensible_audio_ports.len > 0
}

fn test_draft_extensions_contains_extensible_audio_ports() {
	assert draft.ext_extensible_audio_ports in draft.draft_extensions
}
