Extension { #name : 'ByteSymbol' }

{ #category : '*Hermes-Exporter' }
ByteSymbol >> asExportedLiteral [
	^ HESymbol for: self.
]
