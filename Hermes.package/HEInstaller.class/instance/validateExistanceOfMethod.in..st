validating existance
validateExistanceOfMethod: aHEMethod in: aClass
	aClass
		compiledMethodAt: aHEMethod name
		ifPresent: [ :m | 
			(m isFromTrait and:[aClass isTrait not]) ifTrue:[ ^self ].  	
			self error: 'The method ' , aHEMethod name asString , ' already exists in class ' , aClass name asString ]
		ifAbsent: [  ]