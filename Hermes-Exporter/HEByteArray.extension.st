Extension { #name : #HEByteArray }

{ #category : #'*Hermes-Exporter' }
HEByteArray >> doWriteInto: aWriter [
	aWriter writeByteArray: value.
]
