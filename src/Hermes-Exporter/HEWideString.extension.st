Extension { #name : 'HEWideString' }

{ #category : '*Hermes-Exporter' }
HEWideString >> doWriteInto: aWriter [
	aWriter writeByteArray: value utf8Encoded.
]
