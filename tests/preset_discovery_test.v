import clap.factory.draft

fn test_preset_discovery_factory_id_nonempty() {
	assert draft.preset_discovery_factory_id.len > 0
}

fn test_location_kind_constants() {
	assert draft.location_kind_file == 0
	assert draft.location_kind_plugin == 1
}

fn test_flags_constants() {
	assert draft.is_factory_content == 1 << 0
	assert draft.is_user_content == 1 << 1
	assert draft.is_demo_content == 1 << 2
	assert draft.is_favorite == 1 << 3
}

fn test_timestamp_unknown() {
	assert draft.timestamp_unknown == 0
}
