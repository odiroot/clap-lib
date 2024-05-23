module ext

import clap

@[typedef]
struct C.clap_note_name_t {
pub:
	name    clap.Name
	port    i16 // -1 for every port .
	key     i16 // -1 for every key.
	channel i16 // -1 for every channel.
}

pub type NoteName = C.clap_note_name_t

@[typedef]
struct C.clap_plugin_note_name_t {
pub:
	// Return the number of note names.
	// [main-thread]
	count fn (plugin &clap.Plugin) u32
	// Returns true on success and stores the result into note_name.
	// [main-thread]
	get fn (plugin &clap.Plugin, index u32, note_name &NoteName) bool
}

pub type PluginNoteName = C.clap_plugin_note_name_t

@[typedef]
struct C.clap_host_note_name_t {
pub:
	// Informs the host that the note names have changed.
	// [main-thread]
	changed fn (host &clap.Host)
}

pub type HostNoteName = C.clap_host_note_name_t
