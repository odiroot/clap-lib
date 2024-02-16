module clap

// Every method must be thread-safe.
@[typedef]
struct C.clap_plugin_entry_t {
pub:
	clap_version Version
	// This function must be called first, and can only be called once.
	// It should be as fast as possible, in order to perform a very quick
	// scan of the plugin descriptors.
	// If init() returns false, then the host must not call deinit() nor any
	// other clap related symbols from the DSO.
	// plugin_path is the path to the DSO (Linux, Windows), or the bundle (macOS).
	init fn (plugin_path &char) bool
	// No more calls into the DSO must be made after calling deinit().
	deinit fn ()
	// Returns null if the factory is not provided.
	get_factory fn (factory_id &char) voidptr
}

pub type PluginEntry = C.clap_plugin_entry_t
