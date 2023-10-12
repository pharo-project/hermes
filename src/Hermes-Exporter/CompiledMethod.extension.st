Extension { #name : 'CompiledMethod' }

{ #category : '*Hermes-Exporter' }
CompiledMethod >> asExportedLiteral [
	^ HEMethodLiteral for:self.
]
