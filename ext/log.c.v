module ext

import clap

pub type LogSeverity = int

pub const log_debug = LogSeverity(C.CLAP_LOG_DEBUG)
pub const log_info = LogSeverity(C.CLAP_LOG_INFO)
pub const log_warning = LogSeverity(C.CLAP_LOG_WARNING)
pub const log_error = LogSeverity(C.CLAP_LOG_ERROR)
pub const log_fatal = LogSeverity(C.CLAP_LOG_FATAL)
// These severities should be used to report misbehaviour.
// The plugin one can be used by a layer between the plugin and the host.
pub const log_host_misbehaving = LogSeverity(C.CLAP_LOG_HOST_MISBEHAVING)
pub const log_plugin_misbehaving = LogSeverity(C.CLAP_LOG_PLUGIN_MISBEHAVING)

@[typedef]
struct C.clap_host_log_t {
pub:
	log fn (host &clap.Host, severity LogSeverity, msg &char)
}

pub type HostLog = C.clap_host_log_t
