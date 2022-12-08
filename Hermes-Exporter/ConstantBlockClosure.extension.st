Extension { #name : #ConstantBlockClosure }

{ #category : #'*Hermes-Exporter' }
ConstantBlockClosure >> asExportedLiteral [
	
	^ HEConstantBlock for: self
]
