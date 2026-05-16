module draft

import clap

@[typedef]
struct C.clap_plugin_resource_directory_t {
pub:
	// [main-thread]
	set_directory fn (plugin &clap.Plugin, path &char, is_shared bool)
	// [main-thread]
	collect fn (plugin &clap.Plugin, all bool)
	// [main-thread]
	get_files_count fn (plugin &clap.Plugin) u32
	// [main-thread]
	get_file_path fn (plugin &clap.Plugin, index u32, path &char, path_size u32) int
}

pub type PluginResourceDirectory = C.clap_plugin_resource_directory_t

@[typedef]
struct C.clap_host_resource_directory_t {
pub:
	// [main-thread]
	request_directory fn (host &clap.Host, is_shared bool) bool
	// [main-thread]
	release_directory fn (host &clap.Host, is_shared bool)
}

pub type HostResourceDirectory = C.clap_host_resource_directory_t
