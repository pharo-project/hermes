Extension { #name : #HEExportedLiteral }

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> checkAllTags [
	self assert: (self allSubclasses size = (self allSubclasses collect:#tag as:Set) size)
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral >> doWriteInto: aWriter [
	self subclassResponsibility.
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> for: aValue [
	^ self new
		value: aValue;
		yourself
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> missingTags [
	^ self allSubclasses reject: [ :e | e class canUnderstand: #tag ]
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> nextTag [
	^(self allSubclasses
		collect: [ :e | 
			(e class canUnderstand: #tag)
				ifTrue: [ e tag ]
				ifFalse: [ -1 ] ]) max + 1
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral >> writeInto: aWriter [
	aWriter writeByte: self class tag.
	self doWriteInto: aWriter.
]
