Extension { #name : #TraitComposition }

{ #category : #'*Hermes-Exporter' }
TraitComposition >> asExportedLiteral [
	
	^ HETraitCompositionExporter export: self.
]
