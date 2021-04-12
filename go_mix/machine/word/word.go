package word

import (
)


const MIX_BPB uint = 6
const HOST_BPB uint = 8
const WORD_SIZE uint = 6

type MIXByte struct {
	data byte
}
func NewMIXByte(b byte) MIXByte {
	var mb MIXByte
	mb.Set(b)
	return mb
}
func (m *MIXByte) Set(b byte) {
	if b >= 1<<MIX_BPB {
		panic("MIXByte Overflow")
	}
	m.data = b
}

type Word [WORD_SIZE]MIXByte

