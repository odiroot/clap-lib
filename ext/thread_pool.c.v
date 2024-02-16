module ext

import clap

// This extension lets the plugin use the host's thread pool.
// The plugin must provide clap_plugin_thread_pool, and the host may
// provide clap_host_thread_pool.
// If it doesn't, the plugin should process its data by its own means.
// In the worst case, a single threaded for-loop.
// Be aware that using a thread pool may break hard real-time rules due to
// the thread synchronization involved.
// If the host knows that it is running under hard real-time pressure it may
// decide to not provide this interface.
@[typedef]
struct C.clap_plugin_thread_pool_t {
pub:
	// Called by the thread pool
	exec fn (plugin &clap.Plugin, task_index u32)
}

pub type PluginThreadPool = C.clap_plugin_thread_pool_t

@[typedef]
struct C.clap_host_thread_pool_t {
	// Schedule num_tasks jobs in the host thread pool.
	// It can't be called concurrently or from the thread pool.
	// Will block until all the tasks are processed.
	// This must be used exclusively for realtime processing within the
	// process call.
	// Returns true if the host did execute all the tasks, false if it
	// rejected the request.
	// The host should check that the plugin is within the process call,
	// and if not, reject the exec request.
	// [audio-thread]
	request_exec fn(host &clap.Host, num_tasks u32) bool
}

pub type HostThreadPool = C.clap_host_thread_pool_t

