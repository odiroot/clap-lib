module ext

import clap

// The audio ports scan has to be done while the plugin is deactivated.
@[typedef]
struct C.clap_plugin_latency_t {
pub:
	// Returns the plugin latency in samples.
	// [main-thread]
	get fn (plugin &clap.Plugin) u32
}

pub type PluginLatency = C.clap_plugin_latency_t

@[typedef]
struct C.clap_host_latency_t {
pub:
	// Tell the host that the latency changed.
	// The latency is only allowed to change if the plugin is deactivated.
	// If the plugin is activated, call host.request_restart()
	// [main-thread]
	changed fn (host &clap.Host)
}

pub type HostLatency = C.clap_host_latency_t
