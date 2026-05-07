module draft

import clap

// Trigger event
@[typedef]
struct C.clap_event_trigger_t {
pub:
	header clap.EventHeader

	// target trigger
	trigger_id clap.Id // @ref clap_trigger_info.id
	cookie     voidptr // @ref clap_trigger_info.cookie

	// target a specific note_id, port, key and channel, -1 for global
	note_id    int
	port_index i16
	channel    i16
	key        i16
}

pub type EventTrigger = C.clap_event_trigger_t

pub const event_trigger = u16(C.CLAP_EVENT_TRIGGER)

// Trigger info flags
pub const trigger_is_automatable_per_note_id = u32(C.CLAP_TRIGGER_IS_AUTOMATABLE_PER_NOTE_ID)
pub const trigger_is_automatable_per_key = u32(C.CLAP_TRIGGER_IS_AUTOMATABLE_PER_KEY)
pub const trigger_is_automatable_per_channel = u32(C.CLAP_TRIGGER_IS_AUTOMATABLE_PER_CHANNEL)
pub const trigger_is_automatable_per_port = u32(C.CLAP_TRIGGER_IS_AUTOMATABLE_PER_PORT)

pub type TriggerInfoFlags = u32

// Trigger rescan flags
pub const trigger_rescan_info = u32(C.CLAP_TRIGGER_RESCAN_INFO)
pub const trigger_rescan_all = u32(C.CLAP_TRIGGER_RESCAN_ALL)

pub type TriggerRescanFlags = u32

// Trigger clear flags
pub const trigger_clear_all = u32(C.CLAP_TRIGGER_CLEAR_ALL)
pub const trigger_clear_automations = u32(C.CLAP_TRIGGER_CLEAR_AUTOMATIONS)

pub type TriggerClearFlags = u32

// This describes a trigger
@[typedef]
struct C.clap_trigger_info_t {
pub:
	id     clap.Id
	flags  TriggerInfoFlags
	cookie voidptr

	// displayable name
	name [clap.name_size]char

	// the module path containing the trigger, eg: "sequencers/seq1"
	// '/' will be used as a separator to show a tree like structure.
	module [clap.path_size]char
}

pub type TriggerInfo = C.clap_trigger_info_t

@[typedef]
struct C.clap_plugin_triggers_t {
pub:
	// Returns the number of triggers.
	// [main-thread]
	count fn (plugin &clap.Plugin) u32

	// Copies the trigger's info to trigger_info and returns true on success.
	// [main-thread]
	get_info fn (plugin &clap.Plugin, index u32, trigger_info &TriggerInfo) bool
}

pub type PluginTriggers = C.clap_plugin_triggers_t

@[typedef]
struct C.clap_host_triggers_t {
pub:
	// Rescan the full list of triggers according to the flags.
	// [main-thread]
	rescan fn (host &clap.Host, flags TriggerRescanFlags)

	// Clears references to a trigger.
	// [main-thread]
	clear fn (host &clap.Host, trigger_id clap.Id, flags TriggerClearFlags)
}

pub type HostTriggers = C.clap_host_triggers_t
