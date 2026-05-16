module draft

import clap

@[typedef]
struct C.clap_host_transport_control_t {
pub:
	// [main-thread]
	request_start fn (host &clap.Host)
	// [main-thread]
	request_stop fn (host &clap.Host)
	// [main-thread]
	request_continue fn (host &clap.Host)
	// [main-thread]
	request_pause fn (host &clap.Host)
	// [main-thread]
	request_toggle_play fn (host &clap.Host)
	// [main-thread]
	request_jump fn (host &clap.Host, position clap.BeatTime)
	// [main-thread]
	request_loop_region fn (host &clap.Host, start clap.BeatTime, duration clap.BeatTime)
	// [main-thread]
	request_toggle_loop fn (host &clap.Host)
	// [main-thread]
	request_enable_loop fn (host &clap.Host, is_enabled bool)
	// [main-thread]
	request_record fn (host &clap.Host, is_recording bool)
	// [main-thread]
	request_toggle_record fn (host &clap.Host)
}

pub type HostTransportControl = C.clap_host_transport_control_t
