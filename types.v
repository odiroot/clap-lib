module clap

pub type Name = [name_size]char


pub fn(b Name) str() string {
	chars := unsafe { tos3(b[0]) }
	return "'${chars}'"
}

pub type Path = [path_size]char

pub fn(b Path) str() string {
	chars := unsafe { tos3(b[0]) }
	return "'${chars}'"
}
