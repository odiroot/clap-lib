module clap

// Plugin category.

// Add this feature if your plugin can process note events and then produce audio.
pub const feature_instrument = C.CLAP_PLUGIN_FEATURE_INSTRUMENT
// Add this feature if your plugin is an audio effect.
pub const feature_audio_effect = C.CLAP_PLUGIN_FEATURE_AUDIO_EFFECT
// Add this feature if your plugin is a note effect or a note generator/sequencer.
pub const feature_note_effect = C.CLAP_PLUGIN_FEATURE_NOTE_EFFECT
// Add this feature if your plugin converts audio to notes.
pub const feature_note_detector = C.CLAP_PLUGIN_FEATURE_NOTE_DETECTOR
// Add this feature if your plugin is an analyzer.
pub const feature_analyzer = C.CLAP_PLUGIN_FEATURE_ANALYZER

// Plugin sub-category.
pub const feature_synthesizer = C.CLAP_PLUGIN_FEATURE_SYNTHESIZER
pub const feature_sampler = C.CLAP_PLUGIN_FEATURE_SAMPLER
pub const feature_drum = C.CLAP_PLUGIN_FEATURE_DRUM
pub const feature_drum_machine = C.CLAP_PLUGIN_FEATURE_DRUM_MACHINE

pub const feature_filter = C.CLAP_PLUGIN_FEATURE_FILTER
pub const feature_phaser = C.CLAP_PLUGIN_FEATURE_PHASER
pub const feature_equalizer = C.CLAP_PLUGIN_FEATURE_EQUALIZER
pub const feature_de_esser = C.CLAP_PLUGIN_FEATURE_DEESSER
pub const feature_phase_vocoder = C.CLAP_PLUGIN_FEATURE_PHASE_VOCODER
pub const feature_granular = C.CLAP_PLUGIN_FEATURE_GRANULAR
pub const feature_frequency_shifter = C.CLAP_PLUGIN_FEATURE_FREQUENCY_SHIFTER
pub const feature_pitch_shifter = C.CLAP_PLUGIN_FEATURE_PITCH_SHIFTER

pub const feature_distortion = C.CLAP_PLUGIN_FEATURE_DISTORTION
pub const feature_transient_shaper = C.CLAP_PLUGIN_FEATURE_TRANSIENT_SHAPER
pub const feature_compressor = C.CLAP_PLUGIN_FEATURE_COMPRESSOR
pub const feature_expander = C.CLAP_PLUGIN_FEATURE_EXPANDER
pub const feature_gate = C.CLAP_PLUGIN_FEATURE_GATE
pub const feature_limiter = C.CLAP_PLUGIN_FEATURE_LIMITER

pub const feature_flanger = C.CLAP_PLUGIN_FEATURE_FLANGER
pub const feature_chorus = C.CLAP_PLUGIN_FEATURE_CHORUS
pub const feature_delay = C.CLAP_PLUGIN_FEATURE_DELAY
pub const feature_reverb = C.CLAP_PLUGIN_FEATURE_REVERB

pub const feature_tremolo = C.CLAP_PLUGIN_FEATURE_TREMOLO
pub const feature_glitch = C.CLAP_PLUGIN_FEATURE_GLITCH

pub const feature_utility = C.CLAP_PLUGIN_FEATURE_UTILITY
pub const feature_pitch_correction = C.CLAP_PLUGIN_FEATURE_PITCH_CORRECTION
pub const feature_restoration = C.CLAP_PLUGIN_FEATURE_RESTORATION

pub const feature_multi_effects = C.CLAP_PLUGIN_FEATURE_MULTI_EFFECTS

pub const feature_mixing = C.CLAP_PLUGIN_FEATURE_MIXING
pub const feature_mastering = C.CLAP_PLUGIN_FEATURE_MASTERING

// Audio capabilities.
pub const feature_mono = C.CLAP_PLUGIN_FEATURE_MONO
pub const feature_stereo = C.CLAP_PLUGIN_FEATURE_STEREO
pub const feature_surround = C.CLAP_PLUGIN_FEATURE_SURROUND
pub const feature_ambisonic = C.CLAP_PLUGIN_FEATURE_AMBISONIC
