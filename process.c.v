module clap

pub type ProcessStatus = int

// Processing failed. The output buffer must be discarded.
pub const process_error = ProcessStatus(C.CLAP_PROCESS_ERROR)
// Processing succeeded, keep processing.
pub const process_continue = ProcessStatus(C.CLAP_PROCESS_CONTINUE)
// Processing succeeded, keep processing if the output is not quiet.
pub const process_continue_if_not_quiet = ProcessStatus(C.CLAP_PROCESS_CONTINUE_IF_NOT_QUIET)
// Rely upon the plugin's tail to determine if the plugin should continue to process.
pub const process_tail = ProcessStatus(C.CLAP_PROCESS_TAIL)
// Processing succeeded, but no more processing is required,
// until the next event or variation in audio input.
pub const process_sleep = ProcessStatus(C.CLAP_PROCESS_SLEEP)

@[typedef]
struct C.clap_process_t {
pub:
	// A steady sample time counter.
	// Set to -1 if not available, otherwise the value must be greater
	// or equal to 0, and must be increased by at least `frames_count` for
	// the next call to process.
	steady_time i64
	// Number of frames to process.
	frames_count u32
	// Time info at sample 0
	// If null, then this is a free running host, no transport events will be provided
	transport &EventTransport
	// Audio buffers, they must have the same count as specified
	// by clap_plugin_audio_ports.count().
	// The index maps to clap_plugin_audio_ports.get().
	// Input buffer and its contents are read-only.
	audio_inputs        &AudioBuffer
	audio_inputs_count  u32
	audio_outputs_count u32
	// The input event list can't be modified.
	// Input read-only event list. The host will deliver these sorted in sample order.
	in_events &InputEvents
	// Output event list.
	// The plugin must insert events in sample sorted order when inserting events.
	out_events &OutputEvents
pub mut:
	audio_outputs &AudioBuffer
}

pub type Process = C.clap_process_t
