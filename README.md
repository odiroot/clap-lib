# clap
Low-level wrapper for CLAP plugin API in V.

The intention of this library is to stay as close to the C version as possible
while offering a more idiomatic V interface.

The biggest departure from the original code is swapping the enums for
a set of constants. This is due to the otherwise awkward usage of V enums
when interacting with C code (e.g. casting required in `match` blocks).

## Usage

Install the V package:

```sh
v install odiroot.clap
```

Use in your code with
```v
import odiroot.clap
```

## Examples

See [here](./examples) for example plugins.

## Compatibility

Currently supporting all non-draft APIs.

Still missing:

 - ext/draft/ambisonic.h
 - ext/draft/audio-ports-activation.h
 - ext/draft/check-for-update.h
 - ext/draft/configurable-audio-ports.h
 - ext/draft/context-menu.h
 - ext/draft/extensible-audio-ports.h
 - ext/draft/midi-mappings.h
 - ext/draft/param-indication.h
 - ext/draft/preset-load.h
 - ext/draft/remote-controls.h
 - ext/draft/resource-directory.h
 - ext/draft/state-context.h
 - ext/draft/surround.h
 - ext/draft/track-info.h
 - ext/draft/transport-control.h
 - ext/draft/triggers.h
 - ext/draft/tuning.h


