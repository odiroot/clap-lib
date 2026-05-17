import clap.ext.draft

fn test_ext_resource_directory_id_nonempty() {
	assert draft.ext_resource_directory.len > 0
}

fn test_draft_extensions_contains_resource_directory() {
	assert draft.ext_resource_directory in draft.draft_extensions
}
