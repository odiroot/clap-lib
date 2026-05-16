import clap.ext.draft

fn test_ext_param_indication_id_nonempty() {
	assert draft.ext_param_indication.len > 0
}

fn test_draft_extensions_contains_param_indication() {
	assert draft.ext_param_indication in draft.draft_extensions
}

fn test_param_indication_automation_constants() {
	assert draft.param_indication_automation_none == 0
	assert draft.param_indication_automation_present == 1
	assert draft.param_indication_automation_playing == 2
	assert draft.param_indication_automation_recording == 3
	assert draft.param_indication_automation_overriding == 4
}
