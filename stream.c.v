module clap

// The return values for the stream read and write functions indicate how
// many bytes were actually read or written.
// You need to use a loop to ensure that you read or write the entirety of
// your state. Don't forget to also consider the negative return values for
// the end of file and IO error codes.

@[typedef]
struct C.clap_istream_t {
pub:
	ctx voidptr // Reserved pointer for the stream.
	// Returns the number of bytes read.
	// 0 indicates end of file and -1 a read error.
	read fn(stream &Istream, buffer voidptr, size u64) i64
}

pub type Istream = C.clap_istream_t

@[typedef]
struct C.clap_ostream_t {
pub:
	ctx voidptr // Reserved pointer for the stream.
	// Returns the number of bytes written; -1 on write error.
	write fn(stream &Ostream, buffer voidptr, size u64) i64
}

pub type Ostream = C.clap_ostream_t
