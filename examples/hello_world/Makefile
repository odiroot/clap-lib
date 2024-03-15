all: hello_world.so

hello_world.so: hello_world.v
	v -cc gcc -shared -enable-globals -skip-unused hello_world.v -show-c-output -g


