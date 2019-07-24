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

	| aClass aChangeSet |
	aClass := self newClass: #HETAClass superclass: Object slots: #(aSlot).
	aClass compile: 'm ^3'.
	
	aChangeSet := changeCollector changeSet.
	
	aClass removeFromSystem.
	aClass := nil.
	
	aChangeSet install.
	
	self assert: (aClass := Smalltalk globals at: #HETAClass) isNotNil.
	self assert: aClass name equals: #HETAClass.
	self assert: (aClass lookupSelector: #m) isNotNil.
	
	self assert: aClass new m equals: 3.
]
