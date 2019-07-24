Class {
	#name : #HEChangeSetTest,
	#superclass : #HEAbstractChangeCollectorTest,
	#category : #'Hermes-Tests-Changes-Collector'
}

{ #category : #tests }
HEChangeSetTest >> testChangeSetIncludesClass [

	self newClass: #HETAClass superclass: Object slots: #(aSlot).
	self assert: (changeCollector changeSet classes anySatisfy: [:e | e className = #HETAClass])
]

{ #category : #tests }
HEChangeSetTest >> testChangeSetIncludesClassAndMethod [

	| aClass aChangeSet |
	aClass := self newClass: #HETAClass superclass: Object slots: #(aSlot).
	aClass compile: 'm ^3'.
	
	aChangeSet := changeCollector changeSet.
	
	self assert: (aChangeSet classes anySatisfy: [:e | e className = #HETAClass]).
	self assert: (aChangeSet methods anySatisfy: [:e | e selector = #m])
]

{ #category : #tests }
HEChangeSetTest >> testChangeSetIncludesMethod [

	trackedClass compile: 'm ^3'.
	self assert: (changeCollector changeSet methods anySatisfy: [:e | e selector = #m])
]

{ #category : #tests }
HEChangeSetTest >> testChangeSetIsWrittenInAByteArray [

	| aClass aChangeSet aByteArray|
	aClass := self newClass: #HETAClass superclass: Object slots: #(aSlot).
	aClass compile: 'm ^3'.
	
	aChangeSet := changeCollector changeSet.
	
	aByteArray := ByteArray streamContents: [:s | aChangeSet writeTo: s].

	self assert: aByteArray isNotNil.
	self assert: aByteArray isNotEmpty 
]

{ #category : #tests }
HEChangeSetTest >> testChangeSetIsWrittenInAByteArrayAndReadAndItIsTheSame [

	| aClass aChangeSet aByteArray anotherChangeSet |
	aClass := self newClass: #HETAClass superclass: Object slots: #(aSlot).
	aClass compile: 'm ^3'.
	
	aChangeSet := changeCollector changeSet.
	
	aByteArray := ByteArray streamContents: [:s | aChangeSet writeTo: s].

	anotherChangeSet := HEChangeSet new 
		readFrom: aByteArray readStream;
		yourself.
		
	self assert: aChangeSet equals: anotherChangeSet
]
