import clap.ext.draft

fn test_ext_state_context_id_nonempty() {
	assert draft.ext_state_context.len > 0
}

fn test_draft_extensions_contains_state_context() {
	assert draft.ext_state_context in draft.draft_extensions
}

fn test_state_context_types() {
	assert draft.state_context_for_duplicate == u32(1)
	assert draft.state_context_for_preset == u32(2)
}
