Extension { #name : 'HEByteString' }

{ #category : '*Hermes-Exporter' }
HEByteString >> doWriteInto: aWriter [
	aWriter writeByteString: value.
]
