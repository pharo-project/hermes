Extension { #name : #RGTraitComposition }

{ #category : #'*Hermes-Ring2' }
RGTraitComposition >> asExportedLiteral [
	
	^ HETraitCompositionExporter export: self traitCompositionString
]
