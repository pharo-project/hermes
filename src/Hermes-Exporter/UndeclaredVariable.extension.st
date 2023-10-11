Extension { #name : #UndeclaredVariable }

{ #category : #'*Hermes-Exporter' }
UndeclaredVariable >> asExportedLiteral [
	^ HEGlobalVariable for:self.
]
