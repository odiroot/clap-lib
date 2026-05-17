import clap.ext.draft

fn test_ext_transport_control_id_nonempty() {
	assert draft.ext_transport_control.len > 0
}

fn test_draft_extensions_contains_transport_control() {
	assert draft.ext_transport_control in draft.draft_extensions
}
