reading
readFrom: aReader
	| numberOfClasses numberOfExtensionMethods |
	version := aReader readInt.
	packageName := aReader readByteSymbol.
	imageVersion := aReader readInt.
	numberOfClasses := aReader readInt.

	1 to: numberOfClasses do: [ :idx | self readClassFrom: aReader ].

	numberOfExtensionMethods := aReader readInt.
	1 to: numberOfExtensionMethods do: [ :idx | extensionMethods add: (HEMethod readFrom: aReader) ]