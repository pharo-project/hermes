Extension { #name : #HETraitTransformation }

{ #category : #'*Hermes-Exporter' }
HETraitTransformation >> doWriteInto: aWriter [
	super doWriteInto: aWriter.
	subject writeInto: aWriter.
]
