module clap

@[heap; typedef]
pub struct C.clap_host_t {
pub:
	clap_version Version
	host_data    voidptr // Reserved pointer for the host.
	name         &char   // Mandatory.
	vendor       &char
	url          &char
	version      &char // Mandatory.
	// Query an extension.
	// The returned pointer is owned by the host.
	// It is forbidden to call it before plugin->init().
	// You can call it within plugin->init() call, and after.
	// [thread-safe]
	get_extension fn (host &Host, extension_id &char) voidptr
	// Request the host to deactivate and then reactivate the plugin.
	// [thread-safe]
	request_restart fn (host &Host)
	// Request the host to activate and start processing the plugin.
	// [thread-safe]
	request_process fn (host &Host)
	// Request the host to schedule a call to plugin->on_main_thread(plugin)
	// on the main thread.
	// [thread-safe]
	request_callback fn (host &Host)
}

// XXX: Workaround because:
// pub type Host = C.clap_host_t
// doesn't pass the @[heap] flag.
@[heap]
pub struct Host {
	C.clap_host_t
}
