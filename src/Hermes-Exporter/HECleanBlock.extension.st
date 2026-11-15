Extension { #name : 'HECleanBlock' }

{ #category : '*Hermes-Exporter' }
HECleanBlock >> doWriteInto: aWriter [

	compiledBlock writeInto: aWriter
]

{ #category : '*Hermes-Exporter' }
HECleanBlock >> value: aCleanBlock [

	value := aCleanBlock.
	compiledBlock := aCleanBlock compiledBlock asExportedLiteral
]
