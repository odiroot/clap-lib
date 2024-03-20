import odiroot.clap { Host, Plugin, PluginDescriptor, PluginEntry }
import odiroot.clap.factory { PluginFactory }

const plugin_features = [
	clap.feature_instrument,
	unsafe { nil },
]!

const plugin_descriptor = PluginDescriptor{
	id: c'org.example.hello_world'
	name: c'Hello World Plugin'
	vendor: c'Acme'
	version: c'1.0.0'
	description: c'Absolutely minimal CLAP plugin'
	features: voidptr(&plugin_features[0])
}

const plugin_factory = PluginFactory{
	get_plugin_count: fn (f &PluginFactory) u32 {
		return 1
	}
	get_plugin_descriptor: fn (f &PluginFactory, index u32) &PluginDescriptor {
		if index != 0 {
			return unsafe { nil }
		}
		return voidptr(&plugin_descriptor)
	}
	create_plugin: fn (f &PluginFactory, host &Host, plugin_id &char) &Plugin {
		if !clap.version_is_compatible(host.clap_version) {
			return unsafe { nil }
		}
		if plugin_id != plugin_descriptor.id {
			return unsafe { nil }
		}

		return dump(voidptr('TODO: Create a plugin'.str))
	}
}

fn get_factory(factory_id &char) voidptr {
	fid := unsafe { factory_id.vstring() }
	if fid != factory.plugin_factory_id {
		return unsafe { nil }
	}

	return &plugin_factory
}

@[markused]
__global clap_entry = PluginEntry{
	init: fn (plugin_path &char) bool {
		return true
	}
	deinit: fn () {}
	get_factory: get_factory
}
