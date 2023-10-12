Extension { #name : 'Metaclass' }

{ #category : '*Hermes-Exporter' }
Metaclass >> asExportedLiteral [
	^ HEExportedMetaclass for:self.
]
