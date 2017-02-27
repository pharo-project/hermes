writing
writeInto: aWriter
	aWriter writeByteString: className.
	aWriter writeByteString: superclass.
	aWriter writeByteString: instanceVariables.
	aWriter writeByteString: classInstancevariables.
	aWriter writeByteString: classVariables.
	aWriter writeByteString: sharedPools.
	aWriter writeByteString: category.
	aWriter writeByteString: layoutClass.
	
	aWriter writeInt: methods size.
	methods do:[:e | e writeInto:aWriter].
	
	aWriter writeInt: classSideMethods size.
	classSideMethods do:[:e | e writeInto:aWriter].
	
	traitComposition writeInto: aWriter.
	classTraitComposition writeInto: aWriter.	