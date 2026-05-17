import clap.ext.draft

fn test_ext_check_for_update_id_nonempty() {
	assert draft.ext_check_for_update.len > 0
}

fn test_draft_extensions_contains_check_for_update() {
	assert draft.ext_check_for_update in draft.draft_extensions
}
