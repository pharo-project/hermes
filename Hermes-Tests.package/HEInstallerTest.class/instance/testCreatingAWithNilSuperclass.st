tests
testCreatingAWithNilSuperclass
	| exportedClass slots classSlots |
	
	exportedClass := HEClass for: HETeSimpleClassWithNilSuperclass. 
	self changeNameOf: exportedClass to: #HETeSimpleClassWithNilSuperclassNew.
	
	aClass := builder build: exportedClass.
	
	self assert: aClass name equals: #HETeSimpleClassWithNilSuperclassNew.
	self assert: aClass class name equals: #'HETeSimpleClassWithNilSuperclassNew class'.
	
	slots :=  {#anInstanceVariable => InstanceVariableSlot}.
	(slots at:1) index: 1.	
	self assert: aClass slots equals: slots.
	
	classSlots :=  #().
	self assert: aClass class slots equals: classSlots.
	
	self assert: aClass traitComposition isEmpty.
	self assert: aClass classVariables equals: { #AClassVariable => ClassVariable }.
	
	builder installClass: aClass in: exportedClass category.
	builder installMethods: exportedClass into: aClass.

	self assert: aClass traitComposition isEmpty.
	self assert: aClass class traitComposition isEmpty.

	self assert: aClass superclass equals: nil