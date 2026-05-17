# vclap-lib

[![License](https://img.shields.io/github/license/odiroot/clap-lib)](LICENSE)

Low-level, high-performance V wrapper for the [CLAP (CLever Audio Plugin)](https://cleveraudio.org/) API.

This library provides a near-zero overhead interface to CLAP, staying as close to the C version as possible while offering an idiomatic V experience.

## Features

- **Full Compatibility:** Supports 100% of the CLAP v1.1.10 API, including all stable and draft extensions.
- **Idiomatic V:** Swaps awkward C enums for V constants to allow seamless usage in `match` blocks and bitwise operations without constant casting.
- **Type Safety:** Leverages V's type system with `@[typedef]` and appropriate type aliases for a safer developer experience compared to raw C.
- **Zero Dependencies:** Pure V and C headers, keeping your plugin binaries lean.

## Usage

### Installation

Install via V's package manager:

```sh
v install odiroot.clap
```

### Quick Start

```v
import odiroot.clap
import odiroot.clap.ext // For regular extensions.
import odiroot.clap.ext.draft // For draft extensions.

println('CLAP Version: ${clap.version.major}.${clap.version.minor}.${clap.version.revision}')
println('Supported extensions: ${ext.extensions}')
println('Supported draft extensions: ${draft.draft_extensions}')
```

## Why Constants over Enums?

The biggest departure from the original C headers is the use of `const` sets instead of `enum`. In V, interacting with C-style enums often requires verbose casting in `match` blocks or when performing flag-based logic. By using constants, we maintain the performance of the C API while gaining the readability and ease of use of V.

## Examples

Check the [examples](./examples) directory for a "Hello World" plugin implementation to get started.

## Compatibility

- **CLAP Version:** 1.1.10
- **Status:** All core APIs and extensions (including drafts) are implemented.

## Contributing

Contributions are welcome! Please ensure that all changes pass the CI test suite:
```sh
v test .
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
