Extension { #name : #Integer }

{ #category : #'*Hermes-Exporter' }
Integer >> asExportedLiteral [
	^ HEInteger for: self
]
