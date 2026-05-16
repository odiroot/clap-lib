module draft

import clap

@[typedef]
struct C.clap_host_transport_control_t {
pub:
	request_start         fn (host &clap.Host)
	request_stop          fn (host &clap.Host)
	request_continue      fn (host &clap.Host)
	request_pause         fn (host &clap.Host)
	request_toggle_play   fn (host &clap.Host)
	request_jump          fn (host &clap.Host, position clap.BeatTime)
	request_loop_region   fn (host &clap.Host, start clap.BeatTime, duration clap.BeatTime)
	request_toggle_loop   fn (host &clap.Host)
	request_enable_loop   fn (host &clap.Host, is_enabled bool)
	request_record        fn (host &clap.Host, is_recording bool)
	request_toggle_record fn (host &clap.Host)
}

pub type HostTransportControl = C.clap_host_transport_control_t
