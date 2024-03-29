module clap

// Mandatory fields must be set and must not be blank.
// Otherwise the fields can be null or blank, though it is safer to make them blank.
@[typedef]
struct C.clap_plugin_descriptor_t {
pub:
	clap_version Version = Version{}
	// id is an arbitrary string which should be unique to your plugin,
	// we encourage you to use a reverse URI.
	id          &char // Mandatory.
	name        &char // Mandatory.
	vendor      &char
	url         &char = c''
	manual_url  &char = c''
	support_url &char = c''
	version     &char
	description &char
	// Arbitrary list of keywords.
	// The array of pointers must be null terminated.
	features &&char
}

pub type PluginDescriptor = C.clap_plugin_descriptor_t

pub fn (descriptor PluginDescriptor) id_is_compatible(id &char) bool {
	// voidptr prevent warnings about `const char *`.
	our_id := unsafe { cstring_to_vstring(voidptr(id)) }
	their_id := unsafe { cstring_to_vstring(voidptr(descriptor.id)) }
	return our_id == their_id
}

@[typedef]
struct C.clap_plugin_t {
pub:
	desc        &PluginDescriptor
	plugin_data voidptr // Reserved pointer for the plugin.

	// Must be called after creating the plugin.
	// If init returns false, the host must destroy the plugin instance.
	// If init returns true, then the plugin is initialized and in the deactivated state.
	// [main-thread]
	init             fn (plugin &Plugin) bool
	// Free the plugin and its resources.
	// It is required to deactivate the plugin prior to this call.
	// [main-thread & !active]
	destroy          fn (plugin &Plugin)
	// Activate and deactivate the plugin.
	// In this call the plugin may allocate memory and prepare everything needed for the process
	// call. The process's sample rate will be constant and process's frame count will included in
	// the [min, max] range, which is bounded by [1, INT32_MAX].
	// Once activated the latency and port configuration must remain constant, until deactivation.
	// Returns true on success.
	// [main-thread & !active_state]
	activate         fn (plugin &Plugin, sample_rate f64, min_frames_count u32, max_frames_count u32) bool
	// [main-thread & active_state]
	deactivate       fn (plugin &Plugin)
	// Call start processing before processing.
	// Returns true on success.
	// [audio-thread & active_state & !processing_state]
	start_processing fn (plugin &Plugin) bool
	// Call stop processing before sending the plugin to sleep.
	// [audio-thread & active_state & processing_state]
	stop_processing  fn (plugin &Plugin)
	// - Clears all buffers, performs a full reset of the processing state and kills all voices.
	// [audio-thread & active_state]
	reset            fn (plugin &Plugin)
	// Process audio, events, etc.
	// All the pointers coming from clap_process_t and its nested attributes,
	// are valid until process() returns.
	// [audio-thread & active_state & processing_state]
	process          fn (plugin &Plugin, process &Process) ProcessStatus
	// Query an extension.
	// The returned pointer is owned by the plugin.
	// It is forbidden to call it before plugin->init().
	// You can call it within plugin->init() call, and after.
	// [thread-safe]
	get_extension    fn (plugin &Plugin, id &char) voidptr
	// Called by the host on the main thread in response to a previous call to:
	//   host.request_callback(host);
	// [main-thread]
	on_main_thread   fn (plugin &Plugin)
}

pub type Plugin = C.clap_plugin_t
