module clap

// Defaults to current version of the library.
@[typedef]
struct C.clap_version_t {
pub:
	major    u32 = version_major
	minor    u32 = version_minor
	revision u32 = version_revision
}

pub type Version = C.clap_version_t

pub const version_major = u32(C.CLAP_VERSION_MAJOR)
pub const version_minor = u32(C.CLAP_VERSION_MINOR)
pub const version_revision = u32(C.CLAP_VERSION_REVISION)

// Current version of the library.
pub const version = Version{version_major, version_minor, version_revision}

fn C.clap_version_is_compatible(C.clap_version_t) bool

pub fn version_is_compatible(version Version) bool {
	return C.clap_version_is_compatible(version)
}
