import odiroot.clap { Host, Plugin, PluginDescriptor, PluginEntry, Process, ProcessStatus }
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

@[heap]
struct HelloWorldPlugin {}

fn HelloWorldPlugin.init(cp &Plugin) bool {
	// Unwrap the plugin implementation from clap envelope.
	hwp := unsafe { &HelloWorldPlugin(cp.plugin_data) }
	eprintln('The plugin is: ${hwp}')
	return true
}

fn HelloWorldPlugin.noop(cp &Plugin) {} // For the unimportant parts.

fn HelloWorldPlugin.activate(cp &Plugin, rate f64, min_fcount u32, max_fcount u32) bool {
	return true
}

fn HelloWorldPlugin.start_processing(cp &Plugin) bool {
	return true
}

fn HelloWorldPlugin.process(cp &Plugin, pdata &Process) ProcessStatus {
	return clap.process_sleep
}

fn HelloWorldPlugin.get_extension(cp &Plugin, id &char) voidptr {
	// It's not required to support any extension.
	// The plugin will just do nothing.
	return unsafe { nil }
}

const plugin_factory = PluginFactory{
	get_plugin_count: fn (f &PluginFactory) u32 {
		return 1
	}
	get_plugin_descriptor: fn (f &PluginFactory, index u32) &PluginDescriptor {
		if index != 0 {
			return unsafe { nil }
		}
		return &plugin_descriptor
	}
	create_plugin: fn (f &PluginFactory, host &Host, plugin_id &char) &Plugin {
		if !clap.version_is_compatible(host.clap_version) {
			return unsafe { nil }
		}
		if !plugin_descriptor.id_is_compatible(plugin_id) {
			return unsafe { nil }
		}

		// Clap plugin envelope.
		hwp := HelloWorldPlugin{}
		return &Plugin{
			desc: &plugin_descriptor
			plugin_data: &hwp // Actual plugin implementation.
			init: HelloWorldPlugin.init
			destroy: HelloWorldPlugin.noop
			activate: HelloWorldPlugin.activate
			deactivate: HelloWorldPlugin.noop
			start_processing: HelloWorldPlugin.start_processing
			stop_processing: HelloWorldPlugin.noop
			reset: HelloWorldPlugin.noop
			process: HelloWorldPlugin.process
			get_extension: HelloWorldPlugin.get_extension
			on_main_thread: HelloWorldPlugin.noop
		}
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
