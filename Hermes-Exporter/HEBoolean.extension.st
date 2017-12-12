Extension { #name : #HEBoolean }

{ #category : #'*Hermes-Exporter' }
HEBoolean >> doWriteInto: aWriter [
	aWriter writeByte:(value ifTrue:1 ifFalse:0).
]
