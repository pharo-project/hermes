validating existance
validateExistanceOfClass: aHEClass.
	(environment hasClassNamed: aHEClass className) ifTrue:[
		self error: 'The class ' , aHEClass className asString, ' already exists. Should not be overwritten'.	
	].