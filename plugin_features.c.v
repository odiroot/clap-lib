module clap

// Plugin category.

// Add this feature if your plugin can process note events and then produce audio.
pub const feature_instrument = &char(C.CLAP_PLUGIN_FEATURE_INSTRUMENT)
// Add this feature if your plugin is an audio effect.
pub const feature_audio_effect = &char(C.CLAP_PLUGIN_FEATURE_AUDIO_EFFECT)
// Add this feature if your plugin is a note effect or a note generator/sequencer.
pub const feature_note_effect = &char(C.CLAP_PLUGIN_FEATURE_NOTE_EFFECT)
// Add this feature if your plugin converts audio to notes.
pub const feature_note_detector = &char(C.CLAP_PLUGIN_FEATURE_NOTE_DETECTOR)
// Add this feature if your plugin is an analyzer.
pub const feature_analyzer = &char(C.CLAP_PLUGIN_FEATURE_ANALYZER)

// Plugin sub-category.
pub const feature_synthesizer = &char(C.CLAP_PLUGIN_FEATURE_SYNTHESIZER)
pub const feature_sampler = &char(C.CLAP_PLUGIN_FEATURE_SAMPLER)
pub const feature_drum = &char(C.CLAP_PLUGIN_FEATURE_DRUM)
pub const feature_drum_machine = &char(C.CLAP_PLUGIN_FEATURE_DRUM_MACHINE)

pub const feature_filter = &char(C.CLAP_PLUGIN_FEATURE_FILTER)
pub const feature_phaser = &char(C.CLAP_PLUGIN_FEATURE_PHASER)
pub const feature_equalizer = &char(C.CLAP_PLUGIN_FEATURE_EQUALIZER)
pub const feature_de_esser = &char(C.CLAP_PLUGIN_FEATURE_DEESSER)
pub const feature_phase_vocoder = &char(C.CLAP_PLUGIN_FEATURE_PHASE_VOCODER)
pub const feature_granular = &char(C.CLAP_PLUGIN_FEATURE_GRANULAR)
pub const feature_frequency_shifter = &char(C.CLAP_PLUGIN_FEATURE_FREQUENCY_SHIFTER)
pub const feature_pitch_shifter = &char(C.CLAP_PLUGIN_FEATURE_PITCH_SHIFTER)

pub const feature_distortion = &char(C.CLAP_PLUGIN_FEATURE_DISTORTION)
pub const feature_transient_shaper = &char(C.CLAP_PLUGIN_FEATURE_TRANSIENT_SHAPER)
pub const feature_compressor = &char(C.CLAP_PLUGIN_FEATURE_COMPRESSOR)
pub const feature_expander = &char(C.CLAP_PLUGIN_FEATURE_EXPANDER)
pub const feature_gate = &char(C.CLAP_PLUGIN_FEATURE_GATE)
pub const feature_limiter = &char(C.CLAP_PLUGIN_FEATURE_LIMITER)

pub const feature_flanger = &char(C.CLAP_PLUGIN_FEATURE_FLANGER)
pub const feature_chorus = &char(C.CLAP_PLUGIN_FEATURE_CHORUS)
pub const feature_delay = &char(C.CLAP_PLUGIN_FEATURE_DELAY)
pub const feature_reverb = &char(C.CLAP_PLUGIN_FEATURE_REVERB)

pub const feature_tremolo = &char(C.CLAP_PLUGIN_FEATURE_TREMOLO)
pub const feature_glitch = &char(C.CLAP_PLUGIN_FEATURE_GLITCH)

pub const feature_utility = &char(C.CLAP_PLUGIN_FEATURE_UTILITY)
pub const feature_pitch_correction = &char(C.CLAP_PLUGIN_FEATURE_PITCH_CORRECTION)
pub const feature_restoration = &char(C.CLAP_PLUGIN_FEATURE_RESTORATION)

pub const feature_multi_effects = &char(C.CLAP_PLUGIN_FEATURE_MULTI_EFFECTS)

pub const feature_mixing = &char(C.CLAP_PLUGIN_FEATURE_MIXING)
pub const feature_mastering = &char(C.CLAP_PLUGIN_FEATURE_MASTERING)

// Audio capabilities.
pub const feature_mono = &char(C.CLAP_PLUGIN_FEATURE_MONO)
pub const feature_stereo = &char(C.CLAP_PLUGIN_FEATURE_STEREO)
pub const feature_surround = &char(C.CLAP_PLUGIN_FEATURE_SURROUND)
pub const feature_ambisonic = &char(C.CLAP_PLUGIN_FEATURE_AMBISONIC)
