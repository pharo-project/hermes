Class {
	#name : #HEAbstractChangeCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'changeCollector',
		'packageName',
		'outsideName',
		'trackedClass',
		'noTrackedClass'
	],
	#category : #'Hermes-Tests-Changes-Collector'
}

{ #category : #asserting }
HEAbstractChangeCollectorTest >> assertHasClass: aName [ 

	self assert: (changeCollector allClasses anySatisfy: [:e | e className = aName])
]

{ #category : #asserting }
HEAbstractChangeCollectorTest >> assertHasMethod: aSelector inClassNamed: aClassName [

	self assert: (changeCollector allMethods anySatisfy: [:e | e selector = aSelector and: [ e className = aClassName ]])
]

{ #category : #running }
HEAbstractChangeCollectorTest >> newClass: className superclass: aSuperclass slots: slots [

	^ self newClass: className superclass: aSuperclass slots: slots package: packageName


]

{ #category : #running }
HEAbstractChangeCollectorTest >> newClass: className superclass: aSuperclass slots: slots package: aPackageName [

	^ ShiftClassInstaller
		make: [ :builder | 
			builder
				name: className;
				superclass: aSuperclass;
				slots: slots;
				sharedVariables: '';
				sharedPools: '';
				category: aPackageName ]
]

{ #category : #running }
HEAbstractChangeCollectorTest >> newNonTrackedClass: className superclass: aSuperclass slots: slots [

	^ self newClass: className superclass: aSuperclass slots: slots package: outsideName


]

{ #category : #running }
HEAbstractChangeCollectorTest >> setUp [
	
	super setUp.
	
	packageName := #'Hermes-Tests-Changes-Collected'.
	outsideName := #'Hermes-Tests-Changes-NonCollected'.
	
	RPackageOrganizer default createPackageNamed: packageName.
	RPackageOrganizer default createPackageNamed: outsideName.	
	
	trackedClass := self newClass: #HETTrackedClass superclass: Object slots: #().
	noTrackedClass := self newNonTrackedClass: #HETNoTrackedClass superclass: Object slots: #().
	
	changeCollector := HEChangesCollector new.
	changeCollector subscribeTo: SystemAnnouncer uniqueInstance.
	changeCollector monitor: packageName.
		
]

{ #category : #running }
HEAbstractChangeCollectorTest >> tearDown [
	
	| package |

	changeCollector unsubcribe.
		
	package := packageName asPackageIfAbsent: [ nil ].
	package ifNotNil: [ package removeFromSystem ].
	
	package := outsideName asPackageIfAbsent: [ nil ].
	package ifNotNil: [ package removeFromSystem ].

	super tearDown
]
