tests
testCreatingADuplicatedMethodsInSimpleClass
	| exportedClass  |
	
	exportedClass := HEClass for: HETeSimpleClass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassNew.
	
	aClass := builder build: exportedClass.	
	builder installClass: aClass in: exportedClass category.
	builder installMethods: exportedClass into: aClass.

	self should: [builder installMethods: exportedClass into: aClass.] raise: Error.
