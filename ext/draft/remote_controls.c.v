module draft

import clap

// This extension lets the plugin provide a structured way of mapping parameters
// to a hardware controller.
// This is done by providing a set of remote control pages organized by section.
// A page contains up to 8 controls, which references parameters using param_id.

pub const remote_controls_count = 8

@[typedef]
struct C.clap_remote_controls_page_t {
pub:
	section_name clap.Name
	page_id      clap.Id
	page_name    clap.Name
	param_ids    [remote_controls_count]clap.Id
	// This is used to separate device pages versus preset pages.
	// If true, then this page is specific to this preset.
	is_for_preset bool
}

pub type RemoteControlsPage = C.clap_remote_controls_page_t

@[typedef]
struct C.clap_plugin_remote_controls_t {
pub:
	// Returns the number of pages.
	// [main-thread]
	count fn (plugin &clap.Plugin) u32
	// Get a page by index.
	// Returns true on success and stores the result into page.
	// [main-thread]
	get fn (plugin &clap.Plugin, page_index u32, page &RemoteControlsPage) bool
}

pub type PluginRemoteControls = C.clap_plugin_remote_controls_t

@[typedef]
struct C.clap_host_remote_controls_t {
pub:
	// Informs the host that the remote controls have changed.
	// [main-thread]
	changed fn (host &clap.Host)
	// Suggest a page to the host because it corresponds to what the user is
	// currently editing in the plugin's GUI.
	// [main-thread]
	suggest_page fn (host &clap.Host, page_id clap.Id)
}

pub type HostRemoteControls = C.clap_host_remote_controls_t

