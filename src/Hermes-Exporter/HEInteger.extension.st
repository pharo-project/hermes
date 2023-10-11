Extension { #name : #HEInteger }

{ #category : #'*Hermes-Exporter' }
HEInteger >> doWriteInto: aWriter [
	aWriter writeByte: (value sign < 0 ifTrue: [ 1 ]	ifFalse: [ 0 ]).
	aWriter writeByteArray: value asByteArray.
]
