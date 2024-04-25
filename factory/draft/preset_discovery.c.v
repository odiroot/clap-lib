module draft

import clap

// Preset Discovery enables a plug-in host to identify where presets are found,
// what extensions they have, which plug-ins they apply to, and other metadata
// associated with the presets so that they can be indexed and searched for
// quickly within the plug-in host's browser.

pub const preset_discovery_factory_id = unsafe { (&char(C.CLAP_PRESET_DISCOVERY_FACTORY_ID)).vstring() }

pub type PresetDiscoveryLocationKind = u32

// The preset are located in a file on the OS filesystem.
// The location is then a path which works with the OS file system functions
// (open, stat, ...).
// So both '/' and '\' shall work on Windows as a separator.
pub const preset_discovery_location_file = PresetDiscoveryLocationKind(u32(C.CLAP_PRESET_DISCOVERY_LOCATION_FILE))
// The preset is bundled within the plugin DSO itself.
// The location must then be null, as the preset are within the plugin itself
// and then the plugin will act as a preset container.
pub const preset_discovery_location_plugin = PresetDiscoveryLocationKind(u32(C.CLAP_PRESET_DISCOVERY_LOCATION_PLUGIN))

pub type PresetDiscoveryFlags = u32

// This is for factory or sound-pack presets.
pub const preset_discovery_is_factory_content = PresetDiscoveryFlags(u32(C.CLAP_PRESET_DISCOVERY_IS_FACTORY_CONTENT))
// This is for user presets.
pub const preset_discovery_is_user_content = PresetDiscoveryFlags(u32(C.CLAP_PRESET_DISCOVERY_IS_USER_CONTENT))
// This location is meant for demo presets, those are preset which may trigger
// some limitation in the plugin because they require additional features which
// the user needs to purchase or the content itself needs to be bought and is
// only available in demo mode.
pub const preset_discovery_is_demo_content = PresetDiscoveryFlags(u32(C.CLAP_PRESET_DISCOVERY_IS_DEMO_CONTENT))
// This preset is a user's favorite.
pub const preset_discovery_is_favorite = PresetDiscoveryFlags(u32(C.CLAP_PRESET_DISCOVERY_IS_FAVORITE))

// This type defines a timestamp: the number of seconds since UNIX EPOCH.
// See C's time_t time(time_t *).
pub type Timestamp = u64

pub const timestamp_unknown = Timestamp(u64(C.CLAP_TIMESTAMP_UNKNOWN))

// Pair of plugin ABI and plugin identifier.
@[typedef]
struct C.clap_plugin_id_t {
pub:
	// The plugin ABI name, in lowercase.
	abi &char
	// The plugin ID, for example "com.vendor.name".
	// If the ABI rely upon binary plugin ids,
	// then they shall be hex encoded (lower case).
	id &char
}

pub type PluginId = C.clap_plugin_id_t

// Receiver that receives the metadata for a single preset file.
// The host would define the various callbacks in this interface and the preset
// parser function would then call them.
//
// This interface isn't thread-safe.
@[typedef]
struct C.clap_preset_discovery_metadata_receiver_t {
pub:
	// Reserved pointer for the metadata receiver.
	receiver_data voidptr
	// If there is an error reading metadata from a file this should be called
	// with an error message.
	// os_error: the operating system error, if applicable.
	// 			 If not applicable set it to a non-error value, eg:
	//			 0 on unix and Windows.
	on_error fn (receiver &PresetDiscoveryMetadataReceiver, os_error int, error_message &char)
	// This must be called for every preset in the file and before any preset
	// metadata is sent with the calls below.
	// If the preset file is a preset container then name and load_key are
	// mandatory, otherwise they are optional.
	// The load_key is a machine friendly string used to load the preset inside
	// the container via a the preset-load plug-in extension. The load_key can
	// also just be the subpath if that's what the plugin wants but it could
	// also be some other unique id like a database primary key or a binary
	// offset. It's use is entirely up to the plug-in.
	// If the function returns false, then the provider must stop calling back
	// into the receiver.
	begin_preset fn (receiver &PresetDiscoveryMetadataReceiver, name &char, load_key &char) bool
	// Adds a plug-in id that this preset can be used with.
	add_plugin_id fn (receiver &PresetDiscoveryMetadataReceiver, plugin_id &PluginId)
	// Sets the sound pack to which the preset belongs to.
	set_soundpack_id fn (receiver &PresetDiscoveryMetadataReceiver, soundpack_id &char)
	// Sets the flags, see clap_preset_discovery_flags.
	// If unset, they are then inherited from the location.
	set_flags fn (receiver &PresetDiscoveryMetadataReceiver, flags PresetDiscoveryFlags)
	// Adds a creator name for the preset.
	add_creator fn (receiver &PresetDiscoveryMetadataReceiver, creator &char)
	// Sets a description of the preset.
	set_description fn (receiver &PresetDiscoveryMetadataReceiver, description &char)
	// Sets the creation time and last modification time of the preset.
	// If one of the times isn't known, set it to CLAP_TIMESTAMP_UNKNOWN.
	// If this function is not called, then the indexer may look at the file's
	// creation and modification time.
	set_times fn (receiver &PresetDiscoveryMetadataReceiver, creation_time Timestamp, modification_time Timestamp)
	// Adds a feature to the preset.
	// The feature string is arbitrary, it is the indexer's job to understand
	// it and remap it to its internal categorization and tagging system.
	// However, the strings from plugin-features.h should be understood by the
	// indexer and one of the plugin category could be provided to determine if
	// the preset will result into an audio-effect, instrument, ...
	add_feature fn (receiver &PresetDiscoveryMetadataReceiver, feature &char)
	// Adds extra information to the metadata.
	add_extra_info fn (receiver &PresetDiscoveryMetadataReceiver, key &char, value &char)
}

pub type PresetDiscoveryMetadataReceiver = C.clap_preset_discovery_metadata_receiver_t

@[typedef]
struct C.clap_preset_discovery_filetype_t {
pub:
	name        &char
	description &char // Optional.
	// `.' isn't included in the string.
	// If empty or NULL then every file should be matched.
	file_extension &char
}

pub type PresetDiscoveryFileType = C.clap_preset_discovery_filetype_t

@[typedef]
struct C.clap_preset_discovery_location_t {
pub:
	flags PresetDiscoveryFlags
	// Name of this location.
	name &char
	kind PresetDiscoveryLocationKind
	// Actual location in which to crawl presets.
	// For FILE kind, the location can be either a path to a directory or a file.
	// For PLUGIN kind, the location must be null.
	location &char
}

pub type PresetDiscoveryLocation = C.clap_preset_discovery_location_t

// Describes an installed sound pack.
@[typedef]
struct C.clap_preset_discovery_soundpack_t {
pub:
	flags PresetDiscoveryFlags
	// Sound pack identifier.
	id &char
	// Name of this sound pack.
	name &char
	// Optional, reasonably short description of the sound pack.
	description &char
	// Optional, url to the pack's homepage.
	homepage_url &char
	// Optional, sound pack's vendor.
	vendor &char
	// Optional, an image on disk.
	image_path &char
	// Release date, timestamp_unknown if unavailable
	release_timestamp Timestamp
}

pub type PresetDiscoverySoundpack = C.clap_preset_discovery_soundpack_t

// Describes a preset provider.
@[typedef]
struct C.clap_preset_discovery_provider_descriptor_t {
pub:
	clap_version clap.Version
	id           &char
	name         &char
	vendor       &char // Optional.
}

pub type PresetDiscoveryProviderDescriptor = C.clap_preset_discovery_provider_descriptor_t

// This interface isn't thread-safe.
@[typedef]
struct C.clap_preset_discovery_provider_t {
pub:
	desc          &PresetDiscoveryProviderDescriptor
	provider_data voidptr // Reserved pointer for the provider.
	// Initialize the preset provider.
	// It should declare all its locations, filetypes and sound packs.
	// Returns false if initialization failed.
	init fn (provider &PresetDiscoveryProvider) bool
	// Destroys the preset provider.
	destroy fn (provider &PresetDiscoveryProvider)
	// Reads metadata from the given file and passes them to the metadata receiver
	// Returns true on success.
	read_metadata fn (provider &PresetDiscoveryProvider, location_kind PresetDiscoveryLocationKind, location &char, metadata_receiver &PresetDiscoveryMetadataReceiver) bool
	// Query an extension.
	// The returned pointer is owned by the provider.
	// It is forbidden to call it before provider.init().
	// You can call it within provider.init() call, and after.
	get_extension fn (provider &PresetDiscoveryProvider, extension &char) voidptr
}

pub type PresetDiscoveryProvider = C.clap_preset_discovery_provider_t

// This interface isn't thread-safe.
@[typedef]
struct C.clap_preset_discovery_indexer_t {
pub:
	clap_version clap.Version
	name         &char
	vendor       &char // Optional.
	url          &char // Optional.
	version      &char // Optional.

	indexer_data voidptr // Reserved pointer for the indexer.
	// Declares a preset filetype.
	// Don't callback into the provider during this call.
	// Returns false if the filetype is invalid.
	declare_filetype fn (indexer &PresetDiscoveryIndexer, filetype &PresetDiscoveryFileType) bool
	// Declares a preset location.
	// Don't callback into the provider during this call.
	// Returns false if the location is invalid.
	declare_location fn (indexer &PresetDiscoveryIndexer, location &PresetDiscoveryLocation) bool
	// Declares a sound pack.
	// Don't callback into the provider during this call.
	// Returns false if the sound pack is invalid.
	declare_soundpack fn (indexer &PresetDiscoveryIndexer, soundpack &PresetDiscoverySoundpack) bool
	// Query an extension.
	// The returned pointer is owned by the indexer.
	// It is forbidden to call it before provider.init().
	// You can call it within provider.init() call, and after.
	get_extension fn (indexer &PresetDiscoveryIndexer, extension_id &char) voidptr
}

pub type PresetDiscoveryIndexer = C.clap_preset_discovery_indexer_t

// Every methods in this factory must be thread-safe.
// It is encouraged to perform preset indexing in background threads, maybe even
// in background process.
// The host may use clap_plugin_invalidation_factory to detect filesystem changes
// which may change the factory's content.
@[typedef]
struct C.clap_preset_discovery_factory_t {
pub:
	// Get the number of preset providers available.
	// [thread-safe]
	count fn (factory &PresetDiscoveryFactory) u32
	// Retrieves a preset provider descriptor by its index.
	// Returns null in case of error.
	// The descriptor must not be freed.
	// [thread-safe]
	get_descriptor fn (factory &PresetDiscoveryFactory, index u32) &PresetDiscoveryProviderDescriptor
	// Create a preset provider by its id.
	// The returned pointer must be freed by calling
	// preset_provider.destroy(preset_provider).
	// The preset provider is not allowed to use the indexer callbacks in
	// the create method.
	// It is forbidden to call back into the indexer before the indexer
	// calls provider.init().
	// Returns null in case of error.
	// [thread-safe]
	create fn (factory &PresetDiscoveryFactory, indexer &PresetDiscoveryIndexer, provider_id &char) &PresetDiscoveryProvider
}

pub type PresetDiscoveryFactory = C.clap_preset_discovery_factory_t
