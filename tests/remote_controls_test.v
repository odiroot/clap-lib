import clap.ext.draft

fn test_ext_remote_controls_id_nonempty() {
	assert draft.ext_remote_controls.len > 0
}

fn test_draft_extensions_contains_remote_controls() {
	assert draft.ext_remote_controls in draft.draft_extensions
}

fn test_remote_controls_count() {
	assert draft.remote_controls_count == 8
}

fn test_remote_controls_page_struct_size() {
	// Verify the page struct has exactly 8 param_id slots.
	page := draft.RemoteControlsPage{}
	assert page.param_ids.len == 8
}
