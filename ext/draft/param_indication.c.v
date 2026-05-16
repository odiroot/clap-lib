module draft

import clap

pub const param_indication_automation_none = int(C.CLAP_PARAM_INDICATION_AUTOMATION_NONE)
pub const param_indication_automation_present = int(C.CLAP_PARAM_INDICATION_AUTOMATION_PRESENT)
pub const param_indication_automation_playing = int(C.CLAP_PARAM_INDICATION_AUTOMATION_PLAYING)
pub const param_indication_automation_recording = int(C.CLAP_PARAM_INDICATION_AUTOMATION_RECORDING)
pub const param_indication_automation_overriding = int(C.CLAP_PARAM_INDICATION_AUTOMATION_OVERRIDING)

@[typedef]
struct C.clap_plugin_param_indication_t {
pub:
	// [main-thread]
	set_mapping fn (plugin &clap.Plugin, param_id clap.Id, has_mapping bool, color &clap.Color, label &char, description &char)
	// [main-thread]
	set_automation fn (plugin &clap.Plugin, param_id clap.Id, automation_state u32, color &clap.Color)
}

pub type PluginParamIndication = C.clap_plugin_param_indication_t
