initialization
fromPackage: aPackage
	| classDefinedSorted |
	packageName := aPackage name.

	classDefinedSorted := (aPackage definedClasses reject: #isTrait)
		sorted: [ :a :b | a allSuperclasses size < b allSuperclasses size ].
		
	classDefinedSorted do: [ :e | self addClass: (HEClass for: e) ].
	aPackage extensionMethods do: [ :e | extensionMethods add: (HEMethod for: e) ]