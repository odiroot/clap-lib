module draft

import clap

pub const track_info_has_track_name = u64(1 << 0)
pub const track_info_has_track_color = u64(1 << 1)
pub const track_info_has_audio_channel = u64(1 << 2)
pub const track_info_is_for_return_track = u64(1 << 3)
pub const track_info_is_for_bus = u64(1 << 4)
pub const track_info_is_for_master = u64(1 << 5)

pub const clap_name_size = 256

@[typedef]
struct C.clap_track_info_t {
pub:
	flags              u64
	name               [clap_name_size]u8
	color              clap.Color
	audio_channel_count int
	audio_port_type    &char
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
