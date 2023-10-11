Extension { #name : 'UndefinedObject' }

{ #category : '*Hermes-Exporter' }
UndefinedObject >> asExportedLiteral [
	^ HEUndefinedObject for:self.
]
