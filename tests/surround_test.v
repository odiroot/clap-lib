import clap.ext.draft

fn test_ext_surround_id_nonempty() {
	assert draft.ext_surround.len > 0
}

fn test_draft_extensions_contains_surround() {
	assert draft.ext_surround in draft.draft_extensions
}

fn test_surround_port_type() {
	assert draft.port_surround == 'surround'
}

fn test_surround_channel_positions() {
	assert draft.surround_fl == 0
	assert draft.surround_fr == 1
	assert draft.surround_fc == 2
	assert draft.surround_lfe == 3
	assert draft.surround_bl == 4
	assert draft.surround_br == 5
	assert draft.surround_flc == 6
	assert draft.surround_frc == 7
	assert draft.surround_bc == 8
	assert draft.surround_sl == 9
	assert draft.surround_sr == 10
	assert draft.surround_tc == 11
	assert draft.surround_tfl == 12
	assert draft.surround_tfc == 13
	assert draft.surround_tfr == 14
	assert draft.surround_tbl == 15
	assert draft.surround_tbc == 16
	assert draft.surround_tbr == 17
}
