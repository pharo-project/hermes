reading
readFrom: aReader
	| numberOfMethods numberOfClassMethods |
	className := aReader readByteSymbol.
	superclass := aReader readByteSymbol.
	instanceVariables := aReader readByteString.
	classInstancevariables := aReader readByteString.
	classVariables := aReader readByteString.
	sharedPools := aReader readByteString.
	category := aReader readByteSymbol.
	layoutClass := aReader readByteSymbol.

	numberOfMethods := aReader readInt.

	methods := (1 to: numberOfMethods)
		collect: [ :i | HEMethod readFrom: aReader ]
		as: Array.

	numberOfClassMethods := aReader readInt.

	classSideMethods := (1 to: numberOfClassMethods)
		collect: [ :i | HEMethod readFrom: aReader ]
		as: Array