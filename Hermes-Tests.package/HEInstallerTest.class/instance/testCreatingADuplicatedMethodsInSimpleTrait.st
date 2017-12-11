tests
testCreatingADuplicatedMethodsInSimpleTrait
	| exportedTrait |
	
	exportedTrait := HETrait for: THEOneTestTrait. 
	self changeNameOf: exportedTrait to: #THEOneTestTraitNew.
	
	aTrait := builder buildTrait: exportedTrait.	
	builder installMethods: exportedTrait into: aTrait.
	
	self should: [builder installMethods: exportedTrait into: aTrait] raise: Error.	
