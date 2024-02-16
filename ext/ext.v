module ext

pub const ext_audio_ports = unsafe { (&char(C.CLAP_EXT_AUDIO_PORTS)).vstring() }
pub const ext_audio_ports_config = unsafe { (&char(C.CLAP_EXT_AUDIO_PORTS_CONFIG)).vstring() }
pub const ext_event_registry = unsafe { (&char(C.CLAP_EXT_EVENT_REGISTRY)).vstring() }
pub const ext_gui = unsafe { (&char(C.CLAP_EXT_GUI)).vstring() }
pub const ext_latency = unsafe { (&char(C.CLAP_EXT_LATENCY)).vstring() }
pub const ext_log = unsafe { (&char(C.CLAP_EXT_LOG)).vstring() }
pub const ext_note_name = unsafe { (&char(C.CLAP_EXT_NOTE_NAME)).vstring() }
pub const ext_note_ports = unsafe { (&char(C.CLAP_EXT_NOTE_PORTS)).vstring() }
pub const ext_params = unsafe { (&char(C.CLAP_EXT_PARAMS)).vstring() }
pub const ext_posix_fd_support = unsafe { (&char(C.CLAP_EXT_POSIX_FD_SUPPORT)).vstring() }
pub const ext_render = unsafe { (&char(C.CLAP_EXT_RENDER)).vstring() }
pub const ext_state = unsafe { (&char(C.CLAP_EXT_STATE)).vstring() }
pub const ext_tail = unsafe { (&char(C.CLAP_EXT_TAIL)).vstring() }
pub const ext_timer_support = unsafe { (&char(C.CLAP_EXT_TIMER_SUPPORT)).vstring() }
pub const ext_thread_check = unsafe { (&char(C.CLAP_EXT_THREAD_CHECK)).vstring() }
pub const ext_thread_pool = unsafe { (&char(C.CLAP_EXT_THREAD_POOL)).vstring() }
pub const ext_voice_info = unsafe { (&char(C.CLAP_EXT_VOICE_INFO)).vstring() }

pub const extensions = [
	ext_audio_ports,
	ext_audio_ports_config,
	ext_event_registry,
	ext_gui,
	ext_latency,
	ext_log,
	ext_note_name,
	ext_note_ports,
	ext_params,
	ext_posix_fd_support,
	ext_render,
	ext_state,
	ext_tail,
	ext_timer_support,
	ext_thread_check,
	ext_thread_pool,
	ext_voice_info,
]
