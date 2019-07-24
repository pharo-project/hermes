Class {
	#name : #HEMethodChangeCollectorTest,
	#superclass : #HEAbstractChangeCollectorTest,
	#category : #'Hermes-Tests-Changes-Collector'
}

{ #category : #tests }
HEMethodChangeCollectorTest >> testDoesNotTakeNonMonitoringMethods [

	noTrackedClass compile: 'm ^ 42'.
	
	self assert: changeCollector allMethods isEmpty
]

{ #category : #tests }
HEMethodChangeCollectorTest >> testMethodAddedAndDetected [

	trackedClass compile: 'm ^ 42'.
	self assertHasMethod: #m inClassNamed: trackedClass name.
]

{ #category : #tests }
HEMethodChangeCollectorTest >> testMethodModifiedHasOnlyOne [

	trackedClass compile: 'm ^ 42'.
	trackedClass compile: 'm ^ 33'.

	self assert: changeCollector allMethods size equals: 1
]

{ #category : #tests }
HEMethodChangeCollectorTest >> testMethodModifiedKeepsLastOne [

	| heMethod |

	trackedClass compile: 'm ^ 42'.
	trackedClass compile: 'm ^ #asd'.
	
	heMethod := changeCollector allMethods first.

	self assert: (heMethod literals anySatisfy: [ :e | e value = #asd])
]
