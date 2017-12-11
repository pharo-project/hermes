validating existance
validateExistanceOfTrait: aHETrait.
	(environment includesKey: aHETrait traitName) ifTrue:[ 
		self error: 'The trait ' , aHETrait traitName asString, ' already exists. Should not be overwritten'.	
	].