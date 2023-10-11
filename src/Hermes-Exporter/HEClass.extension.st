Extension { #name : 'HEClass' }

{ #category : '*Hermes-Exporter' }
HEClass >> allSuperclassesIn: aCollection [
	"I check that all my dependencies are exported before myself"
	^ aCollection detect:[:aSuper | aSuper className = self superclass]
		ifFound:[ :miSuper | { miSuper } , (miSuper allSuperclassesIn: aCollection) ]
		ifNone:[ #() ]
]

{ #category : '*Hermes-Exporter' }
HEClass >> doWriteHeaderInto: aWriter [
	aWriter writeByteString: className.
	aWriter writeByteString: superclass.
	aWriter writeByteString: instanceVariables.
	aWriter writeByteString: classInstancevariables.
	aWriter writeByteString: classVariables.
	aWriter writeByteString: sharedPools.
	aWriter writeByteString: layoutClass
]

{ #category : '*Hermes-Exporter' }
HEClass class >> for: aClass [
	^ self new
		fromClass: aClass;
		yourself
]

{ #category : '*Hermes-Exporter' }
HEClass >> fromClass: aClass [
	"I fill the header from a real class.
	I do not handle special slots yet"
	className := aClass name.
	superclass := aClass superclass ifNil: '' ifNotNil:#name.
	instanceVariables := (aClass slots collect: #name) joinUsing: ' '.
	classInstancevariables := (aClass class slots collect: #name) joinUsing: ' '.
	classVariables := aClass classPool keys joinUsing: ' '.
	sharedPools := (aClass sharedPools collect: #name) joinUsing: ' '.
	layoutClass := aClass classLayout class name.

	self doFromMethodContainer: aClass
]

{ #category : '*Hermes-Exporter' }
HEClass >> sharedPoolsIn: aCollection [
	^ ((sharedPools substrings collect: #asSymbol) collect: [ :aName | aCollection detect: [ :aClass | aClass className = aName ] ifNone: nil ]) reject: #isNil
]
