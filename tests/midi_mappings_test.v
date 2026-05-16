import clap.ext.draft

fn test_ext_midi_mappings_id_nonempty() {
	assert draft.ext_midi_mappings.len > 0
}

fn test_draft_extensions_contains_midi_mappings() {
	assert draft.ext_midi_mappings in draft.draft_extensions
}

fn test_midi_mapping_types() {
	assert draft.midi_mapping_cc7 == 0
	assert draft.midi_mapping_cc14 == 1
	assert draft.midi_mapping_rpn == 2
	assert draft.midi_mapping_nrpn == 3
}

fn test_midi_mapping_struct() {
	m := draft.MidiMapping{}
	assert m.channel == 0
	assert m.number == 0
	assert m.param_id == 0
}
