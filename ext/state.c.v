module ext

import clap

// Plugins can implement this extension to save and restore both parameter
// values and non-parameter state. This is used to persist a plugin's state
// between project reloads, when duplicating and copying plugin instances, and
// for host-side preset management.

@[typedef]
struct C.clap_plugin_state_t {
pub:
	// Saves the plugin state into stream.
	// Returns true if the state was correctly saved.
	// [main-thread]
	save fn (plugin &clap.Plugin, stream &clap.Ostream) bool
	// Loads the plugin state from stream.
	// Returns true if the state was correctly restored.
	// [main-thread]
	load fn (plugin &clap.Plugin, stream &clap.Istream) bool
}

pub type PluginState = C.clap_plugin_state_t

@[typedef]
struct C.clap_host_state_t {
pub:
	// Tell the host that the plugin state has changed and should be saved again.
	// If a parameter value changes, then it is implicit that the state is dirty.
	// [main-thread]
	mark_dirty fn (host &clap.Host)
}

pub type HostState = C.clap_host_state_t
