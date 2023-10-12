Extension { #name : 'HESendMessage' }

{ #category : '*Hermes-Exporter' }
HESendMessage >> doWriteInto: aWriter [ 
	
	selector writeInto: aWriter.
	receiver writeInto: aWriter.
	arguments writeInto: aWriter
]
