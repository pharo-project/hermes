tests
testCreatingAClassWithUndeclared
	| exportedClass |
	
	exportedClass := HEClass for: HETeSimpleClassReferingClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassReferingUndeclaredNew.
	
	((exportedClass methods at: 1) literals at:1) instVarNamed: #value put: #AUndeclared.
	
	aClass := builder build: exportedClass.
	
	builder installClass: aClass in: exportedClass category.
	builder installMethods: exportedClass into: aClass.

	self assert: builder createdUndeclared size equals: 1.

	self should: [builder validateNoNewUndeclared] raise: Error.