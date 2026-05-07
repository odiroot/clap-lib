import clap.ext.draft

fn test_ext_tuning_id_nonempty() {
	assert draft.ext_tuning.len > 0
}

fn test_draft_extensions_contains_tuning() {
	assert draft.ext_tuning in draft.draft_extensions
}