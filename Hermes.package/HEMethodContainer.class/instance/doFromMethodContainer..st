initialization
doFromMethodContainer: aMethodContainer
	category := aMethodContainer category.
	traitComposition := aMethodContainer traitComposition asExportedLiteral.
	classTraitComposition := aMethodContainer class traitComposition
		asExportedLiteral.

	methods := aMethodContainer methods
		select: [ :e | e isExtension not ]
		thenCollect: [ :e | HEMethod for: e ].

	classSideMethods := aMethodContainer class methods
		select: [ :e | e isExtension not ]
		thenCollect: [ :e | HEMethod for: e ]