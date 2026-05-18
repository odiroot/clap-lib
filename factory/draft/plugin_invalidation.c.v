module draft

pub const plugin_invalidation_factory_id = unsafe { (&char(C.CLAP_PLUGIN_INVALIDATION_FACTORY_ID)).vstring_literal() }

@[typedef]
struct C.clap_plugin_invalidation_source_t {
pub:
	directory      &char // absolute path
	filename_glob  &char // globbing pattern, e.g. "*.dll"
	recursive_scan bool
}

pub type InvalidationSource = C.clap_plugin_invalidation_source_t

@[typedef]
struct C.clap_plugin_invalidation_factory_t {
pub:
	count   fn (factory &InvalidationFactory) u32
	get     fn (factory &InvalidationFactory, index u32) &InvalidationSource
	refresh fn (factory &InvalidationFactory) bool
}

pub type InvalidationFactory = C.clap_plugin_invalidation_factory_t
