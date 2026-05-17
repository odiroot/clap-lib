module draft

import clap

pub const track_info_has_track_name = u64(C.CLAP_TRACK_INFO_HAS_TRACK_NAME)
pub const track_info_has_track_color = u64(C.CLAP_TRACK_INFO_HAS_TRACK_COLOR)
pub const track_info_has_audio_channel = u64(C.CLAP_TRACK_INFO_HAS_AUDIO_CHANNEL)
pub const track_info_is_for_return_track = u64(C.CLAP_TRACK_INFO_IS_FOR_RETURN_TRACK)
pub const track_info_is_for_bus = u64(C.CLAP_TRACK_INFO_IS_FOR_BUS)
pub const track_info_is_for_master = u64(C.CLAP_TRACK_INFO_IS_FOR_MASTER)

@[typedef]
struct C.clap_track_info_t {
pub:
	flags               u64
	name                clap.Name
	color               clap.Color
	audio_channel_count int
	audio_port_type     &char
}

pub type TrackInfo = C.clap_track_info_t

@[typedef]
struct C.clap_plugin_track_info_t {
pub:
	// [main-thread]
	changed fn (plugin &clap.Plugin)
}

pub type PluginTrackInfo = C.clap_plugin_track_info_t

@[typedef]
struct C.clap_host_track_info_t {
pub:
	// [main-thread]
	get fn (host &clap.Host, info &TrackInfo) bool
}

pub type HostTrackInfo = C.clap_host_track_info_t
