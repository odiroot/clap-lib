module clap

pub type BeatTime = i64
pub type SecTime = i64

/// We use fixed point representation of beat time and seconds time
/// Usage:
///   x := ...; // in beats
///   y := round(beattime_factor * x);
pub const beattime_factor = BeatTime(C.CLAP_BEATTIME_FACTOR)
pub const sectime_factor = SecTime(C.CLAP_SECTIME_FACTOR)
