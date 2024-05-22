# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Fixed
* Dropped `clap.Host` heap workaround to fix compilation.

## [0.1.3] - 2024-03-29
### Fixed
* Explicitly cast plugin feature strings to prevent warnings.
* Create a valid default `Version` object for `PluginEntry`.
### Added
* Utility function for verifying plugin id.

## [0.1.2] - 2024-03-13
### Added
* Missing `clap_host_gui_t` support.

## [0.1.1] - 2024-02-28
### Changed
* Main headers ported from C.

