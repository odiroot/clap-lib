import clap.ext.draft

fn test_ext_cv_id_nonempty() {
	assert draft.ext_cv.len > 0
}

fn test_port_cv_id_nonempty() {
	assert draft.port_cv.len > 0
}

fn test_draft_extensions_contains_cv() {
	assert draft.ext_cv in draft.draft_extensions
}

fn test_cv_channel_type_constants() {
	assert draft.cv_value == 0
	assert draft.cv_gate == 1
	assert draft.cv_pitch == 2
}
