module draft

import clap

@[typedef]
struct C.clap_plugin_preset_load_t {
pub:
	// Loads a preset in the plugin native preset file format from a location.
	// The preset discovery provider defines the location and load_key to be
	// passed to this function.
	// Returns true on success.
	// [main-thread]
	from_location fn (plugin &clap.Plugin, location_kind u32, location &char, load_key &char) bool
}

pub type PluginPresetLoad = C.clap_plugin_preset_load_t

@[typedef]
struct C.clap_host_preset_load_t {
pub:
	// Called if clap_plugin_preset_load.load() failed.
	// os_error: the operating system error, if applicable.
	// If not applicable set it to a non-error value, eg: 0 on unix and Windows.
	// [main-thread]
	on_error fn (host &clap.Host, location_kind u32, location &char, load_key &char, os_error int, msg &char)
	// Informs the host that the following preset has been loaded.
	// This contributes to keep in sync the host preset browser and plugin
	// preset browser. If the preset was loaded from a container file,
	// then the load_key must be set, otherwise it must be null.
	// [main-thread]
	loaded fn (host &clap.Host, location_kind u32, location &char, load_key &char)
}

pub type HostPresetLoad = C.clap_host_preset_load_t
