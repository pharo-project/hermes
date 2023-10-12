Extension { #name : 'RGClassVariable' }

{ #category : '*Hermes-Ring2' }
RGClassVariable >> asExportedLiteral [
	^ HEClassVariable for: self
]

{ #category : '*Hermes-Ring2' }
RGClassVariable >> emitStore: methodBuilder [

	methodBuilder storeIntoLiteralVariable: self.


]

{ #category : '*Hermes-Ring2' }
RGClassVariable >> emitValue: methodBuilder [

	methodBuilder pushLiteralVariable: self.
]
