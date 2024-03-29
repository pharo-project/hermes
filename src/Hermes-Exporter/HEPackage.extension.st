Extension { #name : 'HEPackage' }

{ #category : '*Hermes-Exporter' }
HEPackage >> allSharedPoolsOf: aClass in: aCollection [
	"Used to check the dependency order when exporting"
	^ ({aClass} , (aClass allSuperclassesIn: aCollection)) flatCollect: [:e | e sharedPoolsIn: aCollection].
]

{ #category : '*Hermes-Exporter' }
HEPackage class >> for: aPackage [
	^ self new
		fromPackage: aPackage;
		yourself
]

{ #category : '*Hermes-Exporter' }
HEPackage >> fromPackage: aPackage [
	packageName := aPackage name.

	traits := (aPackage definedClasses select: #isTrait) collect: [ :e | HETrait for: e ] as: OrderedCollection.	
	(aPackage definedClasses reject: #isTrait) do: [ :e | self addClass: (HEClass for: e) ].

	extensionMethods := aPackage extensionMethods collect: [ :e | HEMethod for: e ]
]

{ #category : '*Hermes-Exporter' }
HEPackage >> numberOfRequiredClassesOf: aClass in: aCollection [
	"Used to sort the classes by dependency"
	^ ((aClass allSuperclassesIn: aCollection) , ((self allSharedPoolsOf: aClass in: aCollection) flatCollect: [:e | {e} , (e allSuperclassesIn: aCollection)])) size
]

{ #category : '*Hermes-Exporter' }
HEPackage >> sortContent [
	| allClasses|
	"The classes and traits should be ordered by dependencies so it is easier to import in the target image"
	traits := traits sorted: [ :a :b | (a traitComposition allDependenciesIn: traits) size < (b traitComposition allDependenciesIn: traits) size ].
	
	allClasses := classes.
	classes := classes sorted: [ :a :b | (self numberOfRequiredClassesOf: a in: allClasses) < (self numberOfRequiredClassesOf: b in: allClasses) ].

]

{ #category : '*Hermes-Exporter' }
HEPackage >> writeInto: aWriter [
	self sortContent.

	aWriter writeInt32: version.
	aWriter writeByteString: packageName.

	aWriter writeInt32: traits size.
	traits do: [ :each | each writeInto: aWriter ].

	aWriter writeInt32: classes size.
	classes do: [ :each | each writeInto: aWriter ].

	aWriter writeInt32: extensionMethods size.
	extensionMethods do: [ :e | e writeInto: aWriter ].

	aWriter flush.
]
