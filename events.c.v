module clap

// Event header - must be the first attribute of the event.
@[typedef]
struct C.clap_event_header_t {
pub:
	size     u32 // Event size including this header, eg: sizeof(clap_event_note).
	time     u32 // Sample offset within the buffer for this event.
	space_id u16 // Event space, see clap_host_event_registry.
	@type    u16 // Event type.
	flags    u32 // See clap_event_flags.
}

pub type EventHeader = C.clap_event_header_t

// The clap core event space.
pub const core_event_space_id = u16(C.CLAP_CORE_EVENT_SPACE_ID)

pub type EventFlags = u32

// Indicate a live user event, for example a user turning a physical knob
// or playing a physical key.
pub const event_flags_is_live = EventFlags(u32(C.CLAP_EVENT_IS_LIVE))
// Indicate that the event should not be recorded.
// For example this is useful when a parameter changes because of a MIDI CC,
// because if the host records both the MIDI CC automation and the parameter
// automation there will be a conflict.
pub const event_flags_dont_record = EventFlags(u32(C.CLAP_EVENT_DONT_RECORD))

pub type EventType = u16

// These four events use clap_event_note.
// NOTE_ON and NOTE_OFF represent a key pressed and key released event, respectively.
pub const event_note_on = EventType(u16(C.CLAP_EVENT_NOTE_ON))
pub const event_note_off = EventType(u16(C.CLAP_EVENT_NOTE_OFF))
// NOTE_CHOKE is meant to choke the voice(s), like in a drum machine when
// a closed hihat chokes an open hihat.
pub const event_note_choke = EventType(u16(C.CLAP_EVENT_NOTE_CHOKE))
// NOTE_END is sent by the plugin to the host.
pub const event_note_end = EventType(u16(C.CLAP_EVENT_NOTE_END))
// Represents a note expression.
// Uses clap_event_note_expression.
pub const event_note_expression = EventType(u16(C.CLAP_EVENT_NOTE_EXPRESSION))
// PARAM_VALUE sets the parameter's value; uses clap_event_param_value.
pub const event_param_value = EventType(u16(C.CLAP_EVENT_PARAM_VALUE))
// PARAM_MOD sets the parameter's modulation amount; uses clap_event_param_mod.
pub const event_param_mod = EventType(u16(C.CLAP_EVENT_PARAM_MOD))
// Indicates that the user started or finished adjusting a knob.
// Uses clap_event_param_gesture.
pub const event_param_gesture_begin = EventType(u16(C.CLAP_EVENT_PARAM_GESTURE_BEGIN))
pub const event_param_gesture_end = EventType(u16(C.CLAP_EVENT_PARAM_GESTURE_END))
// Update the transport info; clap_event_transport.
pub const event_transport = EventType(u16(C.CLAP_EVENT_TRANSPORT))
// Raw midi event; clap_event_midi.
pub const event_midi = EventType(u16(C.CLAP_EVENT_MIDI))
// Raw midi sysex event; clap_event_midi_sysex.
pub const event_midi_sysex = EventType(u16(C.CLAP_EVENT_MIDI_SYSEX))
// Raw midi 2 event; clap_event_midi2.
pub const event_midi2 = EventType(u16(C.CLAP_EVENT_MIDI2))

// Note on, off, end and choke events.
// In the case of note choke or end events:
// - the velocity is ignored.
// - key and channel are used to match active notes, a value of -1 matches all.
@[typedef]
struct C.clap_event_note_t {
pub:
	header     EventHeader
	note_id    int // -1 if unspecified, otherwise >=0
	port_index i16
	channel    i16 // 0..15
	key        i16 // 0..127
	velocity   f64 // 0..1
}

pub type EventNote = C.clap_event_note_t

pub type NoteExpression = int

// With 0 < x <= 4, plain = 20 * log(x).
pub const note_expression_volume = NoteExpression(C.CLAP_NOTE_EXPRESSION_VOLUME)
// Pan, 0 left, 0.5 center, 1 right.
pub const note_expression_pan = NoteExpression(C.CLAP_NOTE_EXPRESSION_PAN)
// Relative tuning in semitone, from -120 to +120.
pub const note_expression_tuning = NoteExpression(C.CLAP_NOTE_EXPRESSION_TUNING)
// 0..1
pub const note_expression_vibrato = NoteExpression(C.CLAP_NOTE_EXPRESSION_VIBRATO)
pub const note_expression_expression = NoteExpression(C.CLAP_NOTE_EXPRESSION_EXPRESSION)
pub const note_expression_brightness = NoteExpression(C.CLAP_NOTE_EXPRESSION_BRIGHTNESS)
pub const note_expression_pressure = NoteExpression(C.CLAP_NOTE_EXPRESSION_PRESSURE)

@[typedef]
struct C.clap_event_note_expression_t {
pub:
	header        EventHeader
	expression_id NoteExpression
	// Target a specific note_id, port, key and channel, -1 for global.
	note_id    int
	port_index i16
	channel    i16
	key        i16
	value      f64 // See expression for the range.
}

pub type EventNoteExpression = C.clap_event_note_expression_t

@[typedef]
struct C.clap_event_param_value_t {
pub:
	header EventHeader
	// Target parameter.
	param_id Id      // @ref clap_param_info.id
	cookie   voidptr // @ref clap_param_info.cookie
	// Target a specific note_id, port, key and channel, -1 for global.
	note_id    int
	port_index i16
	channel    i16
	key        i16
	value      f64
}

pub type EventParamValue = C.clap_event_param_value_t

@[typedef]
struct C.clap_event_param_mod_t {
pub:
	header EventHeader
	// Target parameter.
	param_id Id      // @ref clap_param_info.id
	cookie   voidptr // @ref clap_param_info.cookie
	// Target a specific note_id, port, key and channel, -1 for global.
	note_id    int
	port_index i16
	channel    i16
	key        i16
	amount     f64 // Modulation amount.
}

pub type EventParamMod = C.clap_event_param_mod_t

@[typedef]
struct C.clap_event_param_gesture_t {
pub:
	header EventHeader
	// Target parameter.
	param_id Id // @ref clap_param_info.id
}

pub type EventParamGesture = C.clap_event_param_gesture_t

pub type TransportFlags = u32

pub const transport_has_tempo = TransportFlags(u32(C.CLAP_TRANSPORT_HAS_TEMPO))
pub const transport_has_beats_timeline = TransportFlags(u32(C.CLAP_TRANSPORT_HAS_BEATS_TIMELINE))
pub const transport_has_seconds_timeline = TransportFlags(u32(C.CLAP_TRANSPORT_HAS_SECONDS_TIMELINE))
pub const transport_has_time_signature = TransportFlags(u32(C.CLAP_TRANSPORT_HAS_TIME_SIGNATURE))
pub const transport_is_playing = TransportFlags(u32(C.CLAP_TRANSPORT_IS_PLAYING))
pub const transport_is_recording = TransportFlags(u32(C.CLAP_TRANSPORT_IS_RECORDING))
pub const transport_is_loop_active = TransportFlags(u32(C.CLAP_TRANSPORT_IS_LOOP_ACTIVE))
pub const transport_is_within_pre_roll = TransportFlags(u32(C.CLAP_TRANSPORT_IS_WITHIN_PRE_ROLL))

@[typedef]
struct C.clap_event_transport_t {
pub:
	header           EventHeader
	flags            u32      // See clap_transport_flags.
	song_pos_beats   BeatTime // Position in beats.
	song_pos_seconds SecTime  // Position in seconds.

	tempo     f64 // In BPM.
	tempo_inc f64 // Tempo increment for each sample and until the next time info event.

	loop_start_beats   BeatTime
	loop_end_beats     BeatTime
	loop_start_seconds SecTime
	loop_end_seconds   SecTime

	bar_start  BeatTime // Start pos of the current bar.
	bar_number int      // Bar at song pos 0 has the number 0.

	tsig_num   u16 // Time signature numerator.
	tsig_denom u16 // Time signature denominator.
}

pub type EventTransport = C.clap_event_transport_t

@[typedef]
struct C.clap_event_midi_t {
pub:
	header     EventHeader
	port_index i16
	data       [3]u8
}

pub type EventMidi = C.clap_event_midi_t

@[typedef]
struct C.clap_event_midi_sysex_t {
pub:
	header     EventHeader
	port_index i16
	buffer     &u8 // MIDI buffer.
	size       u32
}

pub type EventMidiSysex = C.clap_event_midi_sysex_t

@[typedef]
struct C.clap_event_midi2_t {
pub:
	header     EventHeader
	port_index i16
	data       [4]u32
}

pub type EventMidi2 = C.clap_event_midi2_t

// Input event list. The host will deliver these sorted in sample order.
@[typedef]
struct C.clap_input_events_t {
pub:
	ctx voidptr // Reserved pointer for the list.
	// Returns the number of events in the list.
	size fn (list &InputEvents) u32
	// Don't free the returned event, it belongs to the list.
	get fn (list &InputEvents, index u32) &EventHeader
}

pub type InputEvents = C.clap_input_events_t

// Output event list.
// The plugin must insert events in sample sorted order when inserting events.
@[typedef]
struct C.clap_output_events_t {
pub:
	ctx voidptr // Reserved pointer for the list.
	// Pushes a copy of the event
	// Returns false if the event could not be pushed to the queue.
	try_push fn (list &OutputEvents, event &EventHeader) bool
}

pub type OutputEvents = C.clap_output_events_t
