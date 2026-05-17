import clap.ext.draft

fn test_ext_ambisonic_id_nonempty() {
	assert draft.ext_ambisonic.len > 0
}

fn test_port_ambisonic_id_nonempty() {
	assert draft.port_ambisonic.len > 0
}

fn test_draft_extensions_contains_ambisonic() {
	assert draft.ext_ambisonic in draft.draft_extensions
}

fn test_ordering_constants() {
	assert draft.ordering_fuma == 0
	assert draft.ordering_acn == 1
}

fn test_normalization_constants() {
	assert draft.normalization_maxn == 0
	assert draft.normalization_sn3d == 1
	assert draft.normalization_n3d == 2
	assert draft.normalization_sn2d == 3
	assert draft.normalization_n2d == 4
}

fn test_ambisonic_config_struct() {
	config := draft.AmbisonicConfig{}
	assert config.ordering == 0
	assert config.normalization == 0
}
