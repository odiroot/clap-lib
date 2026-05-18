all: hello_world.so

hello_world.so: hello_world.v
	v -cc gcc -shared -skip-unused -gc none hello_world.v
