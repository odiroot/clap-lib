module draft

pub const ext_cv = unsafe { (&char(C.CLAP_EXT_CV)).vstring() }

pub const draft_extensions = [
	ext_cv,
]

