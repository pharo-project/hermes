visiting
visitClass: aClass
	| aHEClass |
	
	aHEClass := HEClass new.
	self visitMethodContainer: aClass using: aHEClass.

	aHEClass className: aClass name.
	aHEClass superclass: aClass superclass name.
	aHEClass instanceVariables: aClass instanceVariablesString.
	aHEClass classInstancevariables: aClass theMetaClass instanceVariablesString.
	aHEClass classVariables: (aClass classPool keys joinUsing: ' ').
	aHEClass sharedPools: ((aClass sharedPools collect: #name) joinUsing: ' ').
	aHEClass layoutClass: aClass ficusClass layout realClassName.
	
	^ aHEClass.