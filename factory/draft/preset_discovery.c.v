module draft

import clap

pub const preset_discovery_factory_id = unsafe { (&char(C.CLAP_PRESET_DISCOVERY_FACTORY_ID)).vstring() }

// Location kind constants
pub const location_kind_file = u32(C.CLAP_PRESET_DISCOVERY_LOCATION_FILE)
pub const location_kind_plugin = u32(C.CLAP_PRESET_DISCOVERY_LOCATION_PLUGIN)

// Flags constants
pub const is_factory_content = u32(C.CLAP_PRESET_DISCOVERY_IS_FACTORY_CONTENT)
pub const is_user_content = u32(C.CLAP_PRESET_DISCOVERY_IS_USER_CONTENT)
pub const is_demo_content = u32(C.CLAP_PRESET_DISCOVERY_IS_DEMO_CONTENT)
pub const is_favorite = u32(C.CLAP_PRESET_DISCOVERY_IS_FAVORITE)

pub type Timestamp = u64

pub const timestamp_unknown = Timestamp(0)

@[typedef]
struct C.clap_plugin_id_t {
pub:
	abi &char
	id  &char
}

pub type PluginId = C.clap_plugin_id_t

@[typedef]
struct C.clap_preset_discovery_metadata_receiver_t {
pub:
	receiver_data   voidptr
	on_error        fn (receiver &MetadataReceiver, os_error int, error_message &char)
	begin_preset    fn (receiver &MetadataReceiver, name &char, load_key &char) bool
	add_plugin_id   fn (receiver &MetadataReceiver, plugin_id &PluginId)
	set_soundpack_id fn (receiver &MetadataReceiver, soundpack_id &char)
	set_flags       fn (receiver &MetadataReceiver, flags u32)
	add_creator     fn (receiver &MetadataReceiver, creator &char)
	set_description fn (receiver &MetadataReceiver, description &char)
	set_timestamps  fn (receiver &MetadataReceiver, creation_time Timestamp, modification_time Timestamp)
	add_feature     fn (receiver &MetadataReceiver, feature &char)
	add_extra_info  fn (receiver &MetadataReceiver, key &char, value &char)
}

pub type MetadataReceiver = C.clap_preset_discovery_metadata_receiver_t

@[typedef]
struct C.clap_preset_discovery_filetype_t {
pub:
	name           &char
	description    &char // optional
	file_extension &char // '.' is not included; empty or NULL matches every file
}

pub type Filetype = C.clap_preset_discovery_filetype_t

@[typedef]
struct C.clap_preset_discovery_location_t {
pub:
	flags    u32    // see flags_* constants
	name     &char  // name of this location
	kind     u32    // see location_kind_*
	location &char  // path or null for PLUGIN kind
}

pub type Location = C.clap_preset_discovery_location_t

@[typedef]
struct C.clap_preset_discovery_soundpack_t {
pub:
	flags            u32        // see flags_* constants
	id               &char      // sound pack identifier
	name             &char      // name of this sound pack
	description      &char      // optional
	homepage_url     &char      // optional
	vendor           &char      // optional
	image_path       &char      // optional
	release_timestamp Timestamp // CLAP_TIMESTAMP_UNKNOWN if unavailable
}

pub type Soundpack = C.clap_preset_discovery_soundpack_t

@[typedef]
struct C.clap_preset_discovery_provider_descriptor_t {
pub:
	clap_version clap.Version
	id           &char
	name         &char
	vendor       &char // optional
}

pub type ProviderDescriptor = C.clap_preset_discovery_provider_descriptor_t

@[typedef]
struct C.clap_preset_discovery_provider_t {
pub:
	desc          &ProviderDescriptor
	provider_data voidptr
	init          fn (provider &Provider) bool
	destroy       fn (provider &Provider)
	get_metadata  fn (provider &Provider, location_kind u32, location &char, metadata_receiver &MetadataReceiver) bool
	get_extension fn (provider &Provider, extension_id &char) voidptr
}

pub type Provider = C.clap_preset_discovery_provider_t

@[typedef]
struct C.clap_preset_discovery_indexer_t {
pub:
	clap_version     clap.Version
	name             &char
	vendor           &char // optional
	url              &char // optional
	version          &char // optional
	indexer_data     voidptr
	declare_filetype fn (indexer &Indexer, filetype &Filetype) bool
	declare_location fn (indexer &Indexer, location &Location) bool
	declare_soundpack fn (indexer &Indexer, soundpack &Soundpack) bool
	get_extension    fn (indexer &Indexer, extension_id &char) voidptr
}

pub type Indexer = C.clap_preset_discovery_indexer_t

@[typedef]
struct C.clap_preset_discovery_factory_t {
pub:
	count           fn (factory &Factory) u32
	get_descriptor  fn (factory &Factory, index u32) &ProviderDescriptor
	create          fn (factory &Factory, indexer &Indexer, provider_id &char) &Provider
}

pub type Factory = C.clap_preset_discovery_factory_t
