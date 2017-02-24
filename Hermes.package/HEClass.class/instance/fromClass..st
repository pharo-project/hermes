initialization
fromClass: aClass
	className := aClass name.
	superclass := aClass superclass name.
	instanceVariables := (aClass slots collect: #name) joinUsing: ' '.
	classInstancevariables := aClass class slots joinUsing: ' '.
	classVariables := aClass classPool keys joinUsing: ' '.
	sharedPools := (aClass sharedPools collect: #name) joinUsing: ' '.
	category := aClass category.
	layoutClass := aClass classLayout class name.

	methods := aClass methods
		select: [ :e | e isExtension not ]
		thenCollect: [ :e | HEMethod for: e ].

	classSideMethods := aClass class methods
		select: [ :e | e isExtension not ]
		thenCollect: [ :e | HEMethod for: e ]