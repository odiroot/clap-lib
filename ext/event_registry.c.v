module ext

import clap

@[typedef]
struct C.clap_host_event_registry_t {
pub:
	// Queries an event space id.
	// The space id 0 is reserved for CLAP's core events. See CLAP_CORE_EVENT_SPACE.
	// Return false and sets *space_id to UINT16_MAX if the space name is
	// unknown to the host.
	// [main-thread]
	query fn (host &clap.Host, space_name &char, space_id &u16) bool
}

pub type HostEventRegistry = C.clap_host_event_registry_t


