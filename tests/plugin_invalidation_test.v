import clap.factory.draft

fn test_plugin_invalidation_factory_id_nonempty() {
	assert draft.plugin_invalidation_factory_id.len > 0
}

fn test_invalidation_source_struct() {
	src := draft.InvalidationSource{}
	assert src.directory == 0
	assert src.filename_glob == 0
	assert src.recursive_scan == false
}
