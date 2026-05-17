module draft

import clap

pub const context_menu_target_kind_global = u32(C.CLAP_CONTEXT_MENU_TARGET_KIND_GLOBAL)
pub const context_menu_target_kind_param = u32(C.CLAP_CONTEXT_MENU_TARGET_KIND_PARAM)

pub const context_menu_item_entry = u32(C.CLAP_CONTEXT_MENU_ITEM_ENTRY)
pub const context_menu_item_check_entry = u32(C.CLAP_CONTEXT_MENU_ITEM_CHECK_ENTRY)
pub const context_menu_item_separator = u32(C.CLAP_CONTEXT_MENU_ITEM_SEPARATOR)
pub const context_menu_item_begin_submenu = u32(C.CLAP_CONTEXT_MENU_ITEM_BEGIN_SUBMENU)
pub const context_menu_item_end_submenu = u32(C.CLAP_CONTEXT_MENU_ITEM_END_SUBMENU)
pub const context_menu_item_title = u32(C.CLAP_CONTEXT_MENU_ITEM_TITLE)

pub type ContextMenuItemKind = u32

@[typedef]
struct C.clap_context_menu_target_t {
pub:
	kind u32
	id   clap.Id
}

pub type ContextMenuTarget = C.clap_context_menu_target_t

@[typedef]
struct C.clap_context_menu_entry_t {
pub:
	label      &char
	is_enabled bool
	action_id  clap.Id
}

pub type ContextMenuEntry = C.clap_context_menu_entry_t

@[typedef]
struct C.clap_context_menu_check_entry_t {
pub:
	label      &char
	is_enabled bool
	is_checked bool
	action_id  clap.Id
}

pub type ContextMenuCheckEntry = C.clap_context_menu_check_entry_t

@[typedef]
struct C.clap_context_menu_item_title_t {
pub:
	title      &char
	is_enabled bool
}

pub type ContextMenuItemTitle = C.clap_context_menu_item_title_t

@[typedef]
struct C.clap_context_menu_submenu_t {
pub:
	label      &char
	is_enabled bool
}

pub type ContextMenuSubmenu = C.clap_context_menu_submenu_t

@[typedef]
struct C.clap_context_menu_builder_t {
pub:
	ctx      voidptr
	add_item fn (builder &ContextMenuBuilder, item_kind ContextMenuItemKind, item_data voidptr) bool
	supports fn (builder &ContextMenuBuilder, item_kind ContextMenuItemKind) bool
}

pub type ContextMenuBuilder = C.clap_context_menu_builder_t

@[typedef]
struct C.clap_plugin_context_menu_t {
pub:
	// [main-thread]
	populate fn (plugin &clap.Plugin, target &ContextMenuTarget, builder &ContextMenuBuilder) bool
	// [main-thread]
	perform fn (plugin &clap.Plugin, target &ContextMenuTarget, action_id clap.Id) bool
}

pub type PluginContextMenu = C.clap_plugin_context_menu_t

@[typedef]
struct C.clap_host_context_menu_t {
pub:
	// [main-thread]
	populate fn (host &clap.Host, target &ContextMenuTarget, builder &ContextMenuBuilder) bool
	// [main-thread]
	perform fn (host &clap.Host, target &ContextMenuTarget, action_id clap.Id) bool
	// [main-thread]
	can_popup fn (host &clap.Host) bool
	// [main-thread]
	popup fn (host &clap.Host, target &ContextMenuTarget, screen_index int, x int, y int) bool
}

pub type HostContextMenu = C.clap_host_context_menu_t
