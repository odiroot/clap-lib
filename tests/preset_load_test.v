import clap.ext.draft

fn test_ext_preset_load_id_nonempty() {
	assert draft.ext_preset_load.len > 0
}

fn test_draft_extensions_contains_preset_load() {
	assert draft.ext_preset_load in draft.draft_extensions
}
