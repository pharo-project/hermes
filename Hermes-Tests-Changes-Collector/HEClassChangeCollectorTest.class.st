Class {
	#name : #HEClassChangeCollectorTest,
	#superclass : #HEAbstractChangeCollectorTest,
	#category : #'Hermes-Tests-Changes-Collector'
}

{ #category : #tests }
HEClassChangeCollectorTest >> testAddedClassIsDetected [

	self newClass: #HETAClass superclass: Object slots: #().
	self assertHasClass: #HETAClass.
]
