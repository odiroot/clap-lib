import clap

fn test_default_version_exposed() {
	assert clap.version.major == 1
	assert clap.version.minor == 1
	assert clap.version.revision == 10
}

fn test_current_version_compatible() {
	assert clap.version_is_compatible(clap.version)
}

