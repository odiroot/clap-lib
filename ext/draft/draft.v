module draft

pub const ext_ambisonic = unsafe { (&char(C.CLAP_EXT_AMBISONIC)).vstring() }
pub const ext_audio_ports_activation = unsafe { (&char(C.CLAP_EXT_AUDIO_PORTS_ACTIVATION)).vstring() }
pub const ext_cv = unsafe { (&char(C.CLAP_EXT_CV)).vstring() }
pub const ext_midi_mappings = unsafe { (&char(C.CLAP_EXT_MIDI_MAPPINGS)).vstring() }
pub const ext_param_indication = unsafe { (&char(C.CLAP_EXT_PARAM_INDICATION)).vstring() }
pub const ext_preset_load = unsafe { (&char(C.CLAP_EXT_PRESET_LOAD)).vstring() }
pub const ext_track_info = unsafe { (&char(C.CLAP_EXT_TRACK_INFO)).vstring() }
pub const ext_tuning = unsafe { (&char(C.CLAP_EXT_TUNING)).vstring() }
pub const ext_remote_controls = unsafe { (&char(C.CLAP_EXT_REMOTE_CONTROLS)).vstring() }
pub const ext_triggers = unsafe { (&char(C.CLAP_EXT_TRIGGERS)).vstring() }

pub const draft_extensions = [
	ext_ambisonic,
	ext_audio_ports_activation,
	ext_cv,
	ext_midi_mappings,
	ext_param_indication,
	ext_preset_load,
	ext_track_info,
	ext_tuning,
	ext_remote_controls,
	ext_triggers,
]
