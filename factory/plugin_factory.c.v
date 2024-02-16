module factory

import clap

pub const plugin_factory_id = unsafe { (&char(C.CLAP_PLUGIN_FACTORY_ID)).vstring() }
// In case you ever need that *exact* string in memory.
pub const plugin_factory_id_ptr = C.CLAP_PLUGIN_FACTORY_ID

// Every method must be thread-safe.
// The host may use clap_plugin_invalidation_factory to detect filesystem
// changes which may change the factory's content.
@[typedef]
struct C.clap_plugin_factory_t {
pub:
	// Get the number of plugins available.
	// [thread-safe]
	get_plugin_count fn (factory &PluginFactory) u32
	// Retrieves a plugin descriptor by its index.
	// Returns null in case of error. The descriptor must not be freed.
	// [thread-safe]
	get_plugin_descriptor fn (factory &PluginFactory, index u32) &clap.PluginDescriptor
	// Create a clap_plugin by its plugin_id.
	// The returned pointer must be freed by calling plugin.destroy(plugin);
	// The plugin is not allowed to use the host callbacks in the create method.
	// Returns null in case of error.
	// [thread-safe]
	create_plugin fn (factory &PluginFactory, host &clap.Host, plugin_id &char) &clap.Plugin
}

pub type PluginFactory = C.clap_plugin_factory_t
