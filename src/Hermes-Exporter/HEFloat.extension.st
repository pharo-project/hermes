Extension { #name : #HEFloat }

{ #category : #'*Hermes-Exporter' }
HEFloat >> doWriteInto: aWriter [
	aWriter writeUInt32: (value at:1).
	aWriter writeUInt32: (value at:2).	
]
