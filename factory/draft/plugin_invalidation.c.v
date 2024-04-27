module draft

pub const plugin_invalidation_factory_id = unsafe { (&char(C.CLAP_PLUGIN_INVALIDATION_FACTORY_ID)).vstring() }

@[typedef]
struct C.clap_plugin_invalidation_source_t {
pub:
	// Directory containing the file(s) to scan, must be absolute.
	directory &char
	// Globing pattern, in the form *.dll
	filename_glob &char
	// should the directory be scanned recursively?
	recursive_scan bool
}

pub type PluginInvalidationSource = C.clap_plugin_invalidation_source_t

// Used to figure out when a plugin needs to be scanned again.
// Imagine a situation with a single entry point: my-plugin.clap which then
// scans itself a set of "sub-plugins". New plugin may be available even if
// my-plugin.clap file doesn't change.
// This interfaces solves this issue and gives a way to the host to monitor
// additional files.
@[typedef]
struct C.clap_plugin_invalidation_factory_t {
pub:
	// Get the number of invalidation sources.
	count fn (factory &PluginInvalidationFactory) u32
	// Get the invalidation source by its index.
	// [thread-safe]
	get fn (factory &PluginInvalidationFactory, index u32) &PluginInvalidationSource
	// In case the host detected a invalidation event, it can call refresh()
	// to let the plugin_entry update the set of plugins available.
	// If the function returned false, then the plugin needs to be reloaded.
	refresh fn (factory &PluginInvalidationFactory) bool
}

pub type PluginInvalidationFactory = C.clap_plugin_invalidation_factory_t
