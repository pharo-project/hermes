Extension { #name : 'HEAdditionalMethodState' }

{ #category : '*Hermes-Exporter' }
HEAdditionalMethodState >> doWriteInto: aWriter [
	method writeInto: aWriter.
	selector writeInto: aWriter.
	value writeInto: aWriter.		
]
