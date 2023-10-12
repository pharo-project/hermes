Extension { #name : #ConstantBlockClosure }

{ #category : #'*Hermes-Exporter-Pharo11' }
ConstantBlockClosure >> asExportedLiteral [
	
	^ HEConstantBlock for: self
]
