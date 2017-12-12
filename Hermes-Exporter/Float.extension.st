Extension { #name : #Float }

{ #category : #'*Hermes-Exporter' }
Float >> asExportedLiteral [
	^ HEFloat for: self
]
