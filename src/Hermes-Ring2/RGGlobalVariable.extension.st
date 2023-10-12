Extension { #name : 'RGGlobalVariable' }

{ #category : '*Hermes-Ring2' }
RGGlobalVariable >> asExportedLiteral [
	^ HEGlobalVariable for:self.
]

{ #category : '*Hermes-Ring2' }
RGGlobalVariable >> emitStore: methodBuilder [
	methodBuilder storeIntoLiteralVariable: self.


]

{ #category : '*Hermes-Ring2' }
RGGlobalVariable >> emitValue: methodBuilder [
	methodBuilder pushLiteralVariable: self.
]
