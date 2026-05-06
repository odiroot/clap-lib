import clap

// Verify we know how to pass audio data buffer to C and read it too.
fn test_smoke() {
	n_channels := 2
	n_samples := 5
	data := [][]f32{len: n_channels, init: []f32{len: n_samples, init: index}}

	// For C interop, need a pointer at the first element of first sub-array.
	ptr := data.map(|y| y.data).data
	buffer := clap.AudioBuffer{
		data32: &&f32(ptr)
	}

	left_constant := (buffer.constant_mask & (1 << 0)) != 0
	right_constant := (buffer.constant_mask & (1 << 1)) != 0
	assert !left_constant
	assert !right_constant

	for i := 0; i < n_samples; i++ {
		l := unsafe { buffer.data32[0][if left_constant { 0 } else { i }] }
		r := unsafe { buffer.data32[1][if right_constant { 0 } else { i }] }
		assert l == r
		assert l == f32(i)
	}
}
