import clap.ext.draft

fn test_ext_triggers_id_nonempty() {
	assert draft.ext_triggers.len > 0
}

fn test_draft_extensions_contains_triggers() {
	assert draft.ext_triggers in draft.draft_extensions
}

fn test_trigger_constants() {
	assert draft.trigger_is_automatable_per_note_id == 1 << 0
	assert draft.trigger_is_automatable_per_key == 1 << 1
	assert draft.trigger_is_automatable_per_channel == 1 << 2
	assert draft.trigger_is_automatable_per_port == 1 << 3
}

fn test_trigger_rescan_flags() {
	assert draft.trigger_rescan_info == 1 << 0
	assert draft.trigger_rescan_all == 1 << 1
}

fn test_trigger_clear_flags() {
	assert draft.trigger_clear_all == 1 << 0
	assert draft.trigger_clear_automations == 1 << 1
}

fn test_trigger_info_struct() {
	info := draft.TriggerInfo{}
	assert info.name.len == 256 // CLAP_NAME_SIZE
	assert info.module.len == 1024 // CLAP_PATH_SIZE
}

fn test_event_trigger_constant() {
	assert draft.event_trigger == 0
}
