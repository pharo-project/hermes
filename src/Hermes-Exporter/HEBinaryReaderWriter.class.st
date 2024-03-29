"
I am an extension to HEBinaryReader that includes the ability to write data to the stream.
The format used is compatible with the one in HEBinaryReader

"
Class {
	#name : 'HEBinaryReaderWriter',
	#superclass : 'HEBinaryReader',
	#category : 'Hermes-Exporter',
	#package : 'Hermes-Exporter'
}

{ #category : 'accessing' }
HEBinaryReaderWriter >> flush [
	stream flush
]

{ #category : 'writting' }
HEBinaryReaderWriter >> writeByte: aNumber [
	stream nextPut: aNumber
]

{ #category : 'writting' }
HEBinaryReaderWriter >> writeByteArray: byteArray [
	self writeInt32: byteArray size.
	stream nextPutAll: byteArray.
]

{ #category : 'writting' }
HEBinaryReaderWriter >> writeByteString: aString [
	self writeByteArray: aString asByteArray
]

{ #category : 'writting' }
HEBinaryReaderWriter >> writeInt32: aNumber [
	| numberToSave |
	numberToSave := aNumber < 0
		ifTrue: [ (0 - aNumber) bitInvert32 + 1 ]
		ifFalse: [ aNumber ].
	1 to: 4 do: [ :i | stream nextPut: (numberToSave byteAt: i) ]
]

{ #category : 'writting' }
HEBinaryReaderWriter >> writeUInt32: aNumber [
	1 to: 4 do: [ :i | stream nextPut: (aNumber byteAt: i) ]
]
