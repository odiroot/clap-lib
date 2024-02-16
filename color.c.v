module clap

@[typedef]
struct C.clap_color_t {
pub:
	alpha u8
	red u8
	green u8
	blue u8
}

pub type Color = C.clap_color_t
