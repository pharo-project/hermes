Class {
	#name : #HEChangeSet,
	#superclass : #Object,
	#instVars : [
		'classes',
		'methods'
	],
	#category : #'Hermes-Changes-Collector'
}

{ #category : #comparing }
HEChangeSet >> = anotherObject [

	anotherObject species = self species
		ifFalse: [ ^ false ].

	^ (anotherObject classes hasEqualElements: self classes)
		and: [ anotherObject methods hasEqualElements: self methods ]
]

{ #category : #accessing }
HEChangeSet >> classes [
	^ classes
]

{ #category : #accessing }
HEChangeSet >> classes: aCollection [ 
	classes := aCollection
]

{ #category : #writing }
HEChangeSet >> doWrite: aHermesWriter [ 
	
	"Write classes"
	aHermesWriter writeUInt32: classes size.
	classes do: [ :e | e writeInto: aHermesWriter ].
	 
	"Write methods"
	aHermesWriter writeUInt32: methods size.
	methods do: [ :e | e writeInto: aHermesWriter ].
	
	aHermesWriter flush.
]

{ #category : #accessing }
HEChangeSet >> methods [
	^ methods
]

{ #category : #accessing }
HEChangeSet >> methods: aCollection [ 
	methods := aCollection
]

{ #category : #reading }
HEChangeSet >> readFrom: aReadStream [ 
	
	| numberOfClasses numberOfMethods reader |
	
	reader := HEBinaryReaderWriter new
		stream: aReadStream;
		yourself.
		
	numberOfClasses := reader readUInt32.
	classes := OrderedCollection new.
	
	1 to: numberOfClasses do: [ :idx | classes add: (HEClass readFrom: reader ) ].
	
	numberOfMethods := reader readUInt32.
	methods := OrderedCollection new.
	
	1 to: numberOfMethods do: [ :idx | methods add: (HEMethod readFrom: reader ) ]
]

{ #category : #writing }
HEChangeSet >> writeTo: aWriteStream [ 
		
	self doWrite: (	HEBinaryReaderWriter new
		stream: aWriteStream;
		yourself)
]
