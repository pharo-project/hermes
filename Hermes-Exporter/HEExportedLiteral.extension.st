Extension { #name : #HEExportedLiteral }

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> checkAllTags [
	"I check that all my subclasses have different tag values"
	self assert: (self allSubclasses size = (self allSubclasses collect:#tag as:Set) size)
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral >> doWriteInto: aWriter [
	"My subclasses should implement the writing strategy"
	self subclassResponsibility.
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> for: aValue [
	"Creates a new instance with this initial value"
	^ self new
		value: aValue;
		yourself
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> missingTags [
	"Check if all my subclasses implements the tag message"
	^ self allSubclasses reject: [ :e | e class canUnderstand: #tag ]
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral class >> nextTag [
	"Finds the next unused tag, useful when creating a new HEExportedLiteral"
	^(self allSubclasses
		collect: [ :e | 
			(e class canUnderstand: #tag)
				ifTrue: [ e tag ]
				ifFalse: [ -1 ] ]) max + 1
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral >> value: anObject [
	value := anObject
]

{ #category : #'*Hermes-Exporter' }
HEExportedLiteral >> writeInto: aWriter [
	"I write the corresponding tag of the class and then my subclasses should implement the custom behavior"
	aWriter writeByte: self class tag.
	self doWriteInto: aWriter.
]
