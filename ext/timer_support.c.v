module ext

import clap

@[typedef]
struct C.clap_plugin_timer_support_t {
pub:
	// [main-thread]
	on_timer fn (plugin &clap.Plugin, timer_id clap.Id)
}

pub type PluginTimerSupport = C.clap_plugin_timer_support_t

@[typedef]
struct C.clap_host_timer_support_t {
pub:
	// Registers a periodic timer.
	// The host may adjust the period if it is under a certain threshold.
	// 30 Hz should be allowed.
	// Returns true on success.
	// [main-thread]
	register_timer fn (host &clap.Host, period_ms u32, timer_id &clap.Id) bool
	// Returns true on success.
	// [main-thread]
	unregister_timer fn (host &clap.Host, timer_id clap.Id) bool
}

pub type HostTimerSupport = C.clap_host_timer_support_t
