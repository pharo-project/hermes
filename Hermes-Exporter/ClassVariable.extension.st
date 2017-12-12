Extension { #name : #ClassVariable }

{ #category : #'*Hermes-Exporter' }
ClassVariable >> asExportedLiteral [
	^ HEClassVariable for: self
]
