module ext

import clap

@[typedef]
struct C.clap_plugin_tail_t {
pub:
	// Returns tail length in samples.
	// Any value greater or equal to INT32_MAX implies infinite tail.
	// [main-thread,audio-thread]
	get fn(plugin &clap.Plugin) u32
}

pub type PluginTail = C.clap_plugin_tail_t

@[typedef]
struct C.clap_host_tail_t {
pub:
	// Tell the host that the tail has changed.
	// [audio-thread]
	changed fn (host &clap.Host)
}

pub type HostTail = C.clap_host_tail_t

