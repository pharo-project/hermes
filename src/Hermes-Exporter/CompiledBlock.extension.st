Extension { #name : 'CompiledBlock' }

{ #category : '*Hermes-Exporter' }
CompiledBlock >> asExportedLiteral [
	^ HECompiledBlock for:self.
]
