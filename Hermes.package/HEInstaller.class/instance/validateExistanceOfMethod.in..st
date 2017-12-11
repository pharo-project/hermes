validating existance
validateExistanceOfMethod: aHEMethod in: aClass
	aClass
		compiledMethodAt: aHEMethod name
		ifPresent: [ :m | 
			self
				error:
					'The method ' , aHEMethod name asString , ' already exists in class '
						, aClass name asString ]
		ifAbsent: [  ]