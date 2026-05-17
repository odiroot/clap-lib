import clap.ext.draft

fn test_ext_context_menu_id_nonempty() {
	assert draft.ext_context_menu.len > 0
}

fn test_draft_extensions_contains_context_menu() {
	assert draft.ext_context_menu in draft.draft_extensions
}

fn test_context_menu_target_kind() {
	assert draft.context_menu_target_kind_global == 0
	assert draft.context_menu_target_kind_param == 1
}

fn test_context_menu_item_kind() {
	assert draft.context_menu_item_entry == 0
	assert draft.context_menu_item_check_entry == 1
	assert draft.context_menu_item_separator == 2
	assert draft.context_menu_item_begin_submenu == 3
	assert draft.context_menu_item_end_submenu == 4
	assert draft.context_menu_item_title == 5
}

fn test_context_menu_target_defaults() {
	t := draft.ContextMenuTarget{}
	assert t.kind == 0
	assert t.id == 0
}
