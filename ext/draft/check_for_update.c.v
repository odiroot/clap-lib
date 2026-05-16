module draft

import clap

@[typedef]
struct C.clap_check_for_update_info_t {
pub:
	version      &char
	release_date &char
	url          &char
	is_preview   bool
}

pub type CheckForUpdateInfo = C.clap_check_for_update_info_t

@[typedef]
struct C.clap_plugin_check_for_update_t {
pub:
	check fn (plugin &clap.Plugin, include_preview bool)
}

pub type PluginCheckForUpdate = C.clap_plugin_check_for_update_t

@[typedef]
struct C.clap_host_check_for_update_t {
pub:
	on_new_version fn (host &clap.Host, update_info &CheckForUpdateInfo)
}

pub type HostCheckForUpdate = C.clap_host_check_for_update_t
