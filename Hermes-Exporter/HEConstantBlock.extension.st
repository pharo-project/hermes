Extension { #name : #HEConstantBlock }

{ #category : #'*Hermes-Exporter' }
HEConstantBlock >> doWriteInto: aWriter [

	aWriter writeUInt32: numArgs.
	literal writeInto: aWriter.
	compiledBlock writeInto: aWriter.

]

{ #category : #'*Hermes-Exporter' }
HEConstantBlock >> value: aConstantBlock [

	value := aConstantBlock.
	numArgs := aConstantBlock numArgs.
	literal := aConstantBlock literal asExportedLiteral.
	compiledBlock := aConstantBlock compiledBlock asExportedLiteral.
]
