import clap.ext

fn test_note_name_type_sizes() {
	nn := ext.NoteName{}  // was: NoteName{}
	assert nn.port == 0
	assert nn.key == 0
	assert nn.channel == 0
}

fn test_note_name_sentinel_values() {
	nn := ext.NoteName{  // was: NoteName{
		port:    -1
		key:     -1
		channel: -1
	}
	assert nn.port == -1
	assert nn.key == -1
	assert nn.channel == -1
}

fn test_ext_note_name_id_nonempty() {
	assert ext.ext_note_name.len > 0  // was: ext_note_name.len
}
