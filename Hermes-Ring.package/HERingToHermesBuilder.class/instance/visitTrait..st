visiting
visitTrait: aTrait
	| aHETrait |
	
	aHETrait := HETrait new.
	self visitMethodContainer: aTrait using: aHETrait.

	aHETrait instVarNamed: #traitName put: aTrait name.
	
	^ aHETrait.