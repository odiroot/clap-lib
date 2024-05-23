module ext

import clap

// The host can at any time read parameters' value on the [main-thread] using
// clap_plugin_params.value().
// There are two options to communicate parameter value changes, and they are
//	not concurrent:
// - send automation points during clap_plugin.process()
// - send automation points during clap_plugin_params.flush(), for parameter
// changes without processing audio
// When the plugin changes a parameter value, it must inform the host.
// It will send CLAP_EVENT_PARAM_VALUE event during process() or flush().
// If the user is adjusting the value, don't forget to mark the beginning and
// end of the gesture by sending CLAP_EVENT_PARAM_GESTURE_BEGIN and
// CLAP_EVENT_PARAM_GESTURE_END events.

pub type ParamInfoFlags = u32

// Is this param stepped? (integer values only)
pub const param_is_stepped = ParamInfoFlags(u32(C.CLAP_PARAM_IS_STEPPED))
// Useful for periodic parameters like a phase.
pub const param_is_periodic = u32(C.CLAP_PARAM_IS_PERIODIC)
// The parameter should not be shown to the user.
pub const param_is_hidden = ParamInfoFlags(u32(C.CLAP_PARAM_IS_HIDDEN))
// The parameter can't be changed by the host.
pub const param_is_readonly = ParamInfoFlags(u32(C.CLAP_PARAM_IS_READONLY))
// This parameter is used to merge the plugin and host bypass button.
// It implies that the parameter is stepped.
// min: 0 -> bypass off; max: 1 -> bypass on
pub const param_is_bypass = ParamInfoFlags(u32(C.CLAP_PARAM_IS_BYPASS))
// When set:
// - automation can be recorded
// - automation can be played back
pub const param_is_automatable = ParamInfoFlags(u32(C.CLAP_PARAM_IS_AUTOMATABLE))
// Does this parameter support per note automations?
pub const param_is_automatable_per_note_id = ParamInfoFlags(u32(C.CLAP_PARAM_IS_AUTOMATABLE_PER_NOTE_ID))
// Does this parameter support per key automations?
pub const param_is_automatable_per_key = ParamInfoFlags(u32(C.CLAP_PARAM_IS_AUTOMATABLE_PER_KEY))
// Does this parameter support per channel automations?
pub const param_is_automatable_per_channel = ParamInfoFlags(u32(C.CLAP_PARAM_IS_AUTOMATABLE_PER_CHANNEL))
// Does this parameter support per port automations?
pub const param_is_automatable_per_port = ParamInfoFlags(u32(C.CLAP_PARAM_IS_AUTOMATABLE_PER_PORT))
// Does this parameter support the modulation signal?
pub const param_is_modulatable = ParamInfoFlags(u32(C.CLAP_PARAM_IS_MODULATABLE))
// Does this parameter support per note modulations?
pub const param_is_modulatable_per_note_id = ParamInfoFlags(u32(C.CLAP_PARAM_IS_MODULATABLE_PER_NOTE_ID))
// Does this parameter support per key modulations?
pub const param_is_modulatable_per_key = ParamInfoFlags(u32(C.CLAP_PARAM_IS_MODULATABLE_PER_KEY))
// Does this parameter support per channel modulations?
pub const param_is_modulatable_per_channel = ParamInfoFlags(u32(C.CLAP_PARAM_IS_MODULATABLE_PER_CHANNEL))
// Does this parameter support per port modulations?
pub const param_is_modulatable_per_port = ParamInfoFlags(u32(C.CLAP_PARAM_IS_MODULATABLE_PER_PORT))
// Any change to this parameter will affect the plugin output and requires
// to be done via process() if the plugin is active.
pub const param_requires_process = ParamInfoFlags(u32(C.CLAP_PARAM_REQUIRES_PROCESS))
// This parameter represents an enumerated value.
// If you set this flag, then you must set CLAP_PARAM_IS_STEPPED too.
// All values from min to max must not have a blank value_to_text().
pub const param_is_enum = ParamInfoFlags(u32(C.CLAP_PARAM_IS_ENUM))

// This describes a plugin parameter.
@[typedef]
struct C.clap_param_info_t {
pub:
	// Stable parameter identifier, it must never change.
	id    clap.Id
	flags ParamInfoFlags
	// This value is optional and set by the plugin.
	// Its purpose is to provide fast access to the plugin parameter object
	// by caching its pointer.
	// Important:
	//  - The cookie is invalidated by a call to
	//    clap_host_params.rescan(CLAP_PARAM_RESCAN_ALL) or when the plugin
	//	  is destroyed.
	//  - The host will either provide the cookie as issued or nullptr in
	//	  events addressing parameters.
	//  - The plugin must gracefully handle the case of a cookie which is nullptr.
	//  - Many plugins will process the parameter events more quickly if the
	//	  host can provide the cookie in a faster time than a hashmap lookup
	//	  per param per event.
	cookie voidptr
	// The display name. eg: "Volume". This does not need to be unique.
	// Do not include the module text in this.
	name clap.Name
	// The module path containing the param, eg: "Oscillators/Wavetable 1".
	@module clap.Path

	min_value     f64
	max_value     f64
	default_value f64
}

pub type ParamInfo = C.clap_param_info_t

@[typedef]
struct C.clap_plugin_params_t {
pub:
	// Returns the number of parameters.
	// [main-thread]
	count fn (plugin &clap.Plugin) u32
	// Copies the parameter's info to param_info.
	// Returns true on success.
	// [main-thread]
	get_info fn (plugin &clap.Plugin, param_index u32, mut param_info ParamInfo) bool
	// Writes the parameter's current value to out_value.
	// Returns true on success.
	// [main-thread]
	get_value fn (plugin &clap.Plugin, param_id clap.Id, out_value &f64) bool
	// Fills out_buffer with a null-terminated UTF-8 string that represents
	// the parameter at the given 'value' argument. eg: "2.3 kHz".
	// Returns true on success.
	// [main-thread]
	value_to_text fn (plugin &clap.Plugin, param_id clap.Id, value f64, out_buffer &char, out_buffer_capacity u32) bool
	// Converts the null-terminated UTF-8 param_value_text into a double
	// and writes it to out_value.
	// Returns true on success.
	// [main-thread]
	text_to_value fn (plugin &clap.Plugin, param_id clap.Id, param_value_text &char, out_value &f64) bool
	// Flushes a set of parameter changes.
	// This method must not be called concurrently to clap_plugin.process().
	// Note: if the plugin is processing, then the process() call will already
	// achieve the parameter update (bi-directional), so a call to flush isn't
	// required, also be aware that the plugin may use the sample offset in
	// process(), while this information would be lost within flush().
	// [active ? audio-thread : main-thread]
	flush fn (plugin &clap.Plugin, in_ &clap.InputEvents, out &clap.OutputEvents)
}

pub type PluginParams = C.clap_plugin_params_t

pub type ParamRescanFlags = u32

// The parameter values did change, eg. after loading a preset.
// The host will scan all the parameters value.
// The host will not record those changes as automation points.
// New values takes effect immediately.
pub const param_rescan_values = ParamRescanFlags(u32(C.CLAP_PARAM_RESCAN_VALUES))
// The value to text conversion changed, and the text needs to be rendered again.
pub const param_rescan_text = ParamRescanFlags(u32(C.CLAP_PARAM_RESCAN_TEXT))
// The parameter info did change, use this flag for:
// - name change
// - module change
// - is_periodic (flag)
// - is_hidden (flag)
// New info takes effect immediately.
pub const param_rescan_info = ParamRescanFlags(u32(C.CLAP_PARAM_RESCAN_INFO))
// Invalidates everything the host knows about parameters.
// It can only be used while the plugin is deactivated.
// If the plugin is activated use clap_host.restart() and delay any change
// until the host calls clap_plugin.deactivate().
pub const param_rescan_all = ParamRescanFlags(u32(C.CLAP_PARAM_RESCAN_ALL))

pub type ParamClearFlags = u32

// Clears all possible references to a parameter.
pub const param_clear_all = ParamClearFlags(u32(C.CLAP_PARAM_CLEAR_ALL))
// Clears all automations to a parameter.
pub const param_clear_automations = ParamClearFlags(u32(C.CLAP_PARAM_CLEAR_AUTOMATIONS))
// Clears all modulations to a parameter.
pub const param_clear_modulations = ParamClearFlags(u32(C.CLAP_PARAM_CLEAR_MODULATIONS))

@[typedef]
struct C.clap_host_params_t {
pub:
	// Rescan the full list of parameters according to the flags.
	// [main-thread]
	rescan fn(host &clap.Host, flags ParamRescanFlags)
	// Clears references to a parameter.
	// [main-thread]
	clear fn(host &clap.Host, param_id clap.Id, flags ParamClearFlags)
	// Request a parameter flush.
	// The host will then schedule a call to either:
	// - clap_plugin.process()
	// - clap_plugin_params.flush()
	// This function is always safe to use and should not be called from
	// an [audio-thread] as the plugin would already be within process()
	// or flush().
	// [thread-safe,!audio-thread]
	request_flush fn(host &clap.Host)
}

pub type HostParams = C.clap_host_params_t

