module draft

import clap

pub const midi_mapping_cc7 = int(C.CLAP_MIDI_MAPPING_CC7)
pub const midi_mapping_cc14 = int(C.CLAP_MIDI_MAPPING_CC14)
pub const midi_mapping_rpn = int(C.CLAP_MIDI_MAPPING_RPN)
pub const midi_mapping_nrpn = int(C.CLAP_MIDI_MAPPING_NRPN)

pub type MidiMappingType = int

@[typedef]
struct C.clap_midi_mapping_t {
pub:
	channel  int
	number   int
	param_id clap.Id
}

pub type MidiMapping = C.clap_midi_mapping_t

@[typedef]
struct C.clap_plugin_midi_mappings_t {
pub:
	// [main-thread]
	count fn (plugin &clap.Plugin) u32
	// Returns true on success and stores the result into mapping.
	// [main-thread]
	get fn (plugin &clap.Plugin, index u32, mapping &MidiMapping) bool
}

pub type PluginMidiMappings = C.clap_plugin_midi_mappings_t

@[typedef]
struct C.clap_host_midi_mappings_t {
pub:
	// [main-thread]
	changed fn (host &clap.Host)
}

pub type HostMidiMappings = C.clap_host_midi_mappings_t
