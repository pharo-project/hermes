Extension { #name : #GlobalVariable }

{ #category : #'*Hermes-Exporter' }
GlobalVariable >> asExportedLiteral [
	^ HEGlobalVariable for:self.
]
