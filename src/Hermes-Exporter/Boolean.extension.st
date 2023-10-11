Extension { #name : #Boolean }

{ #category : #'*Hermes-Exporter' }
Boolean >> asExportedLiteral [
	^ HEBoolean for: self
]
