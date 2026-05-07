module draft

pub const ext_cv = unsafe { (&char(C.CLAP_EXT_CV)).vstring() }
pub const ext_preset_load = unsafe { (&char(C.CLAP_EXT_PRESET_LOAD)).vstring() }
pub const ext_tuning = unsafe { (&char(C.CLAP_EXT_TUNING)).vstring() }

pub const draft_extensions = [
	ext_cv,
	ext_preset_load,
	ext_tuning,
]

