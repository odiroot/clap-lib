module draft

import clap

// This event defines the tuning to be used on the given port/channel.
@[typedef]
struct C.clap_event_tuning_t {
pub:
	header clap.EventHeader

	port_index i16 // -1 global
	channel    i16 // 0..15, -1 global
	tunning_id clap.Id
}

pub type EventTuning = C.clap_event_tuning_t

@[typedef]
struct C.clap_tuning_info_t {
pub:
	tuning_id  clap.Id
	name       [clap.name_size]char
	is_dynamic bool // true if the values may vary with time
}

pub type TuningInfo = C.clap_tuning_info_t

@[typedef]
struct C.clap_plugin_tuning_t {
pub:
	// Called when a tuning is added or removed from the pool.
	// [main-thread]
	changed fn(plugin &clap.Plugin)
}

pub type PluginTuning = C.clap_plugin_tuning_t

// This extension provides a dynamic tuning table to the plugin.
@[typedef]
struct C.clap_host_tuning_t {
pub:
	// Gets the relative tuning in semitones against equal temperament
	// with A4=440Hz. The plugin may query the tuning at a rate that makes
	// sense for *low* frequency modulations.
	// If the tuning_id is not found or equals to invalid_id,
	// then the function shall gracefully return a sensible value.
	// sample_offset is the sample offset from the beginning of the current
	// process block.
	// should_play(...) should be checked before calling this function.
	// [audio-thread & in-process]
	get_relative fn(host &clap.Host, tuning_id clap.Id, channel int, key int, sample_offset u32) f64
	// Returns true if the note should be played.
	// [audio-thread & in-process]
	should_play fn(host &clap.Host, tuning_id clap.Id, channel int, key int) bool
	// Returns the number of tunings in the pool.
	// [main-thread]
	get_tuning_count fn(host &clap.Host) u32
	// Gets info about a tuning.
	// Returns true on success and stores the result into info.
	// [main-thread]
	get_info fn(host &clap.Host, tuning_index u32, info &TuningInfo) bool
}

pub type HostTuning = C.clap_host_tuning_t
