Class {
	#name : #HEChangeSetPropagatorTest,
	#superclass : #HEAbstractChangeCollectorTest,
	#instVars : [
		'propagator',
		'listener'
	],
	#category : #'Hermes-Tests-Changes-Propagator'
}

{ #category : #running }
HEChangeSetPropagatorTest >> setUp [
		
	super setUp.
	
	propagator := HEChangeSetPropagator new.
	propagator connect.

	listener := HEChangeSetListener new.
	listener connect.
	
	self assert: propagator isConnected
]

{ #category : #running }
HEChangeSetPropagatorTest >> tearDown [

	propagator ifNotNil: #disconnect.
	listener ifNotNil: #disconnect.

	super tearDown
]

{ #category : #tests }
HEChangeSetPropagatorTest >> testChangeSetIsWrittenInAByteArrayAndReadAndItIsTheSame [

	| aClass aChangeSet |
	aClass := self newClass: #HETAClass superclass: Object slots: #(aSlot).
	aClass compile: 'm ^3'.
	
	aChangeSet := changeCollector changeSet.
	
	aClass removeFromSystem.
	aClass := nil.
	
	propagator propagate: aChangeSet.

	500 milliSeconds wait.
	
	self assert: (aClass := Smalltalk globals at: #HETAClass) isNotNil.
	self assert: aClass name equals: #HETAClass.
	self assert: (aClass lookupSelector: #m) isNotNil.
	
	self assert: aClass new m equals: 3.
]
