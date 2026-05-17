import clap.ext.draft

fn test_ext_track_info_id_nonempty() {
	assert draft.ext_track_info.len > 0
}

fn test_draft_extensions_contains_track_info() {
	assert draft.ext_track_info in draft.draft_extensions
}

fn test_track_info_flags() {
	assert draft.track_info_has_track_name == u64(1) << 0
	assert draft.track_info_has_track_color == u64(1) << 1
	assert draft.track_info_has_audio_channel == u64(1) << 2
	assert draft.track_info_is_for_return_track == u64(1) << 3
	assert draft.track_info_is_for_bus == u64(1) << 4
	assert draft.track_info_is_for_master == u64(1) << 5
}

fn test_track_info_struct_defaults() {
	info := draft.TrackInfo{}
	assert info.flags == 0
	assert info.audio_channel_count == 0
	assert info.audio_port_type == 0
}
