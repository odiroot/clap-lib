module clap

// Sample code for reading a stereo buffer:
//
// left_constant := (buffer.constant_mask & (1 << 0)) != 0
// right_constant := (buffer.constant_mask & (1 << 1)) != 0
//
// for i := 0; i < N; i++ {
//    l := buffer.data32[0][if left_constant {0} else {i}]
//    r := buffer.data32[1][if right_constant {0} else {i}]
// }
//
@[typedef]
struct C.clap_audio_buffer_t {
pub:
	channel_count u32
	latency       u32 // Latency from/to the audio interface.
	constant_mask u64
pub mut:
	// Either data32 or data64 pointer will be set.
	data32 &&f32
	data64 &&f64
}

pub type AudioBuffer = C.clap_audio_buffer_t
