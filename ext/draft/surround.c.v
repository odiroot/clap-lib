module draft

import clap

pub const surround_fl = int(C.CLAP_SURROUND_FL)
pub const surround_fr = int(C.CLAP_SURROUND_FR)
pub const surround_fc = int(C.CLAP_SURROUND_FC)
pub const surround_lfe = int(C.CLAP_SURROUND_LFE)
pub const surround_bl = int(C.CLAP_SURROUND_BL)
pub const surround_br = int(C.CLAP_SURROUND_BR)
pub const surround_flc = int(C.CLAP_SURROUND_FLC)
pub const surround_frc = int(C.CLAP_SURROUND_FRC)
pub const surround_bc = int(C.CLAP_SURROUND_BC)
pub const surround_sl = int(C.CLAP_SURROUND_SL)
pub const surround_sr = int(C.CLAP_SURROUND_SR)
pub const surround_tc = int(C.CLAP_SURROUND_TC)
pub const surround_tfl = int(C.CLAP_SURROUND_TFL)
pub const surround_tfc = int(C.CLAP_SURROUND_TFC)
pub const surround_tfr = int(C.CLAP_SURROUND_TFR)
pub const surround_tbl = int(C.CLAP_SURROUND_TBL)
pub const surround_tbc = int(C.CLAP_SURROUND_TBC)
pub const surround_tbr = int(C.CLAP_SURROUND_TBR)

pub const port_surround = unsafe { (&char(C.CLAP_PORT_SURROUND)).vstring_literal() }

@[typedef]
struct C.clap_plugin_surround_t {
pub:
	// [main-thread]
	is_channel_mask_supported fn (plugin &clap.Plugin, channel_mask u64) bool
	// [main-thread]
	get_channel_map fn (plugin &clap.Plugin, is_input bool, port_index u32, channel_map &u8, channel_map_capacity u32) u32
}

pub type PluginSurround = C.clap_plugin_surround_t

@[typedef]
struct C.clap_host_surround_t {
pub:
	// [main-thread]
	changed fn (host &clap.Host)
}

pub type HostSurround = C.clap_host_surround_t
