module ext

import clap

// This extension let your plugin hook itself into the host
// select/poll/epoll/kqueue reactor.
// This is useful to handle asynchronous I/O on the main thread.

pub type PosixFdFlags = u32

// IO events flags, they can be used to form a mask which describes:
// - which events you are interested in (register_fd/modify_fd),
// - which events happened (on_fd).
pub const posix_fd_read = PosixFdFlags(u32(C.CLAP_POSIX_FD_READ))
pub const posix_fd_write = PosixFdFlags(u32(C.CLAP_POSIX_FD_WRITE))
pub const posix_fd_error = PosixFdFlags(u32(C.CLAP_POSIX_FD_ERROR))

@[typedef]
struct C.clap_plugin_posix_fd_support_t {
pub:
	// This callback is "level-triggered".
	// It means that a writable fd will continuously produce "on_fd()" events;
	// don't forget using modify_fd() to remove the write notification once you're
	// done writing.
	// [main-thread]
	on_fd fn (plugin &clap.Plugin, fd int, flags PosixFdFlags)
}

pub type PluginPosixFdSupport = C.clap_plugin_posix_fd_support_t

@[typedef]
struct C.clap_host_posix_fd_support_t {
pub:
	// Returns true on success.
	// [main-thread]
	register_fd fn (host &clap.Host, fd int, flags PosixFdFlags) bool
	// Returns true on success.
	// [main-thread]
	modify_fd fn (host &clap.Host, fd int, flags PosixFdFlags) bool
	// Returns true on success.
	// [main-thread]
	unregister_fd fn (host &clap.Host, fd int) bool
}

pub type HostPosixFdSupport = C.clap_host_posix_fd_support_t
