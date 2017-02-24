initialization
fromPackage: aPackage
	packageName := aPackage name.
	(aPackage classes reject: #isTrait) do: [ :e | self addClass: (HEClass for: e) ].
	aPackage extensionMethods do: [ :e | extensionMethods add: (HEMethod for: e) ]