Extension { #name : 'CleanBlockClosure' }

{ #category : '*Hermes-Exporter' }
CleanBlockClosure >> asExportedLiteral [

	^ HECleanBlock for: self
]
