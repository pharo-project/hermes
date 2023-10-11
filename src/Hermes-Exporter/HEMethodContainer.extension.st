Extension { #name : 'HEMethodContainer' }

{ #category : '*Hermes-Exporter' }
HEMethodContainer >> doFromMethodContainer: aMethodContainer [
	"When a class or a trait is transformed all the methods should be transformed.
	In both the class and instance side. Also the trait composition should be handled"

	category := aMethodContainer category.
	traitComposition := aMethodContainer traitComposition
		asExportedLiteral.
	classTraitComposition := aMethodContainer classSide traitComposition
		asExportedLiteral.
	methods := aMethodContainer localMethods
		select: [ :e | e isExtension not ]
		thenCollect: [ :e | HEMethod for: e ].
	classSideMethods := aMethodContainer classSide localMethods
		select: [ :e | e isExtension not ]
		thenCollect: [ :e | HEMethod for: e ]
]

{ #category : '*Hermes-Exporter' }
HEMethodContainer >> doWriteHeaderInto: aWriter [ 
	self subclassResponsibility
]

{ #category : '*Hermes-Exporter' }
HEMethodContainer >> doWriteMethods: aWriter [
	aWriter writeByteString: category.

	aWriter writeInt32: methods size.
	methods do: [ :e | e writeInto: aWriter ].

	aWriter writeInt32: classSideMethods size.
	classSideMethods do: [ :e | e writeInto: aWriter ].

	traitComposition writeInto: aWriter.
	classTraitComposition writeInto: aWriter
]

{ #category : '*Hermes-Exporter' }
HEMethodContainer >> writeInto: aWriter [
	self doWriteHeaderInto: aWriter.
	self doWriteMethods: aWriter
]
