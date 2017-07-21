visiting
visitPackage: aPackage
	| aHEPackage classDefinedSorted |
	aHEPackage := HEPackage new.

	aHEPackage packageName: aPackage name.

	aHEPackage traits:((aPackage definedClasses select: #isTrait) collect: [ :e | e acceptVisitor:self ] as: OrderedCollection).

	classDefinedSorted := (aPackage definedClasses reject: #isTrait) sorted: [ :a :b | a allSuperclasses size < b allSuperclasses size ].

	classDefinedSorted do: [ :e | aHEPackage addClass: (e acceptVisitor:self) ].
	aPackage extensionMethods do: [ :e | aHEPackage extensionMethods add: (e acceptVisitor:self) ].
	
	^ aHEPackage.