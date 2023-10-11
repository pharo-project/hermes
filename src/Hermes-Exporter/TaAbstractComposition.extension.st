Extension { #name : #TaAbstractComposition }

{ #category : #'*Hermes-Exporter' }
TaAbstractComposition >> asExportedLiteral [
	
	^ HETraitCompositionExporter export: self.
]
