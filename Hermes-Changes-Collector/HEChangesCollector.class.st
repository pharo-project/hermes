Class {
	#name : #HEChangesCollector,
	#superclass : #Object,
	#instVars : [
		'monitoredPackageNames',
		'methods',
		'announcer',
		'classes'
	],
	#category : #'Hermes-Changes-Collector'
}

{ #category : #accessing }
HEChangesCollector >> allClasses [
	
	^ classes values
]

{ #category : #accessing }
HEChangesCollector >> allMethods [
	
	^ methods values
]

{ #category : #accessing }
HEChangesCollector >> changeSet [

	^ HEChangeSet new
			classes: self allClasses;
			methods: self allMethods;
			yourself
]

{ #category : #initialization }
HEChangesCollector >> initialize [

	monitoredPackageNames := OrderedCollection new.
	methods := Dictionary new.
	classes := Dictionary new.
]

{ #category : #testing }
HEChangesCollector >> isMonitored: ann [ 

	^ (ann packagesAffected collect: #name) includesAnyOf: monitoredPackageNames.
]

{ #category : #configuring }
HEChangesCollector >> monitor: aPackageName [ 
	
	monitoredPackageNames add: aPackageName 
]

{ #category : #events }
HEChangesCollector >> recordClass: ann [ 
	
	| heClass |
	
	(self isMonitored: ann) 
		ifFalse: [ ^ self ].
	
	heClass := HEClass for: ann classAffected.
	
	classes at: heClass className put: heClass
]

{ #category : #events }
HEChangesCollector >> recordMethod: ann [ 
	
	| heMethod |
	
	(self isMonitored: ann) 
		ifFalse: [ ^ self ].
	
	heMethod := HEMethod for: ann method.
	
	methods at: heMethod className -> heMethod selector put: heMethod
]

{ #category : #initialization }
HEChangesCollector >> subscribeTo: anAnnouncer [ 	
	
	announcer ifNotNil:[ self unsubcribe ].
	
	announcer := anAnnouncer.
	anAnnouncer 	
		when: ClassAdded send: #recordClass: to: self;
		when: ClassModifiedClassDefinition  send: #recordClass: to: self;

		when: MethodAdded send: #recordMethod: to: self;
		when: MethodModified send: #recordMethod: to: self.
		
	

]

{ #category : #initialization }
HEChangesCollector >> unsubcribe [

	announcer unsubscribe: self.
	announcer := nil.

]
