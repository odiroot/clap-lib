module ext

import clap

// This extension indicates the number of voices the synthesizer has.
// It is useful for the host when performing polyphonic modulations,
// because the host needs its own voice management and should try to follow
// what the plugin is doing:
// - make the host's voice pool coherent with what the plugin has,
// - turn the host's voice management to mono when the plugin is mono.

// Allows the host to send overlapping NOTE_ON events.
// The plugin will then rely upon the note_id to distinguish between them.
pub const voice_info_supports_overlapping_notes = C.CLAP_VOICE_INFO_SUPPORTS_OVERLAPPING_NOTES

// voice_count should not be confused with the number of active voices.
// 1 <= voice_count <= voice_capacity
// If the voice_count is 1, then the synth is working in mono and the host
// can decide to only use global modulation mapping.
@[typedef]
struct C.clap_voice_info_t {
pub:
	// Current number of voices that the patch can use.
	voice_count u32
	// Number of allocated voices.
	voice_capacity u32
	flags          u64
}

pub type VoiceInfo = C.clap_voice_info_t

@[typedef]
struct C.clap_plugin_voice_info_t {
pub:
	// Gets the voice info, returns true on success.
	// [main-thread && active]
	get fn (plugin &clap.Plugin, info &VoiceInfo) bool
}

pub type PluginVoiceInfo = C.clap_plugin_voice_info_t

@[typedef]
struct C.clap_host_voice_info_t {
pub:
	// informs the host that the voice info has changed
	// [main-thread]
	changed fn (host &clap.Host)
}

pub type HostVoiceInfo = C.clap_host_voice_info_t
