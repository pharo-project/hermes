Extension { #name : 'HEAssociation' }

{ #category : '*Hermes-Exporter' }
HEAssociation >> doWriteInto: aWriter [
	key writeInto: aWriter.
	value writeInto: aWriter.

]
