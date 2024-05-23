module ext

import clap

// This extension provides a way for the plugin to describe its current
// note ports. If the plugin does not implement this extension, it won't
// have note input or output. The plugin is only allowed to change its note
// ports configuration while it is deactivated.

pub type ClapNoteDialect = u32

// Uses clap_event_note and clap_event_note_expression.
pub const note_dialect_clap = ClapNoteDialect(u32(C.CLAP_NOTE_DIALECT_CLAP))
// Uses clap_event_midi, no polyphonic expression.
pub const note_dialect_midi = ClapNoteDialect(u32(C.CLAP_NOTE_DIALECT_MIDI))
// Uses clap_event_midi, with polyphonic expression (MPE).
pub const note_dialect_midi_mpe = ClapNoteDialect(u32(C.CLAP_NOTE_DIALECT_MIDI_MPE))
// Uses clap_event_midi2.
pub const note_dialect_midi2 = ClapNoteDialect(u32(C.CLAP_NOTE_DIALECT_MIDI2))

@[typedef]
struct C.clap_note_port_info_t {
pub mut:
	// id identifies a port and must be stable.
	// id may overlap between input and output ports.
	id                 clap.Id
	supported_dialects u32 // Bitfield, see ClapNoteDialect.
	preferred_dialect  u32 // One value of ClapNoteDialect.
	name               clap.Name // Displayable name.
}

pub type NotePortInfo = C.clap_note_port_info_t

// The note ports scan has to be done while the plugin is deactivated.
@[typedef]
struct C.clap_plugin_note_ports_t {
pub:
	// Number of ports, for either input or output.
	// [main-thread]
	count fn (plugin &clap.Plugin, is_input bool) u32
	// Get info about a note port.
	// Returns true on success and stores the result into info.
	// [main-thread]
	get fn (plugin &clap.Plugin, index u32, is_input bool, info &NotePortInfo) bool
}

pub type PluginNotePorts = C.clap_plugin_note_ports_t

// The ports have changed, the host shall perform a full scan of the ports.
// This flag can only be used if the plugin is not active.
// If the plugin active, call host.request_restart() and then call rescan()
// when the host calls deactivate()
pub const note_ports_rescan_all = C.CLAP_NOTE_PORTS_RESCAN_ALL
// The ports name did change, the host can scan them right away.
pub const note_ports_rescan_names = C.CLAP_NOTE_PORTS_RESCAN_NAMES

@[typedef]
struct C.clap_host_note_ports_t {
pub:
	// Query which dialects the host supports.
	// [main-thread]
	supported_dialects fn (host &clap.Host) u32
	// Rescan the full list of note ports according to the flags.
	// [main-thread]
	rescan fn (host &clap.Host, flags u32)
}

pub type HostNotePorts = C.clap_host_note_ports_t
