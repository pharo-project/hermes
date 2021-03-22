Class {
	#name : #HEInstallerClassesWithBlocksTest,
	#superclass : #HEInstallerTest,
	#category : #'Hermes-Tests'
}

{ #category : #tests }
HEInstallerClassesWithBlocksTest >> setUp [ 

	| exportedClass |

	super setUp.
	
	exportedClass := HEClass for: HETeSimpleClassWithBlocks. 
	self changeNameOf: exportedClass to: #HETeSimpleClassWithBlocksNew.
	
	aClass := installer build: exportedClass.
	installer installMethods: exportedClass into: aClass.

]

{ #category : #tests }
HEInstallerClassesWithBlocksTest >> testAMethodWithASingleBlockHasCorrectBindingToTheHomeMethod [
	| methodWithSimpleBlock block |
		
	methodWithSimpleBlock := aClass >> #aMethodWithABlock.
	block := methodWithSimpleBlock literals at: 1.
	
	self assert: block isCompiledBlock.
	self assert: (block allLiterals at: 2) equals: methodWithSimpleBlock.


]

{ #category : #tests }
HEInstallerClassesWithBlocksTest >> testAMethodWithNestedBlocksHasCorrectBindingOfTheHomeBlockInTheNested [
		
	| methodWithNestedBlocks block nestedBlock |
	methodWithNestedBlocks := aClass >> #aMethodWithNestedBlocks.
	block := methodWithNestedBlocks literals at: 1.
	nestedBlock := block literals at: 1.
	
	self assert: block isCompiledBlock.
	self assert: (block allLiterals last) equals: methodWithNestedBlocks.
	self assert: nestedBlock isCompiledBlock.
	self assert: (nestedBlock allLiterals last) equals: block.
]

{ #category : #tests }
HEInstallerClassesWithBlocksTest >> testCreatedClassHaveTheCorrectName [

	self assert: aClass name equals: #HETeSimpleClassWithBlocksNew.
	self assert: aClass class name equals: #'HETeSimpleClassWithBlocksNew class'.


]

{ #category : #tests }
HEInstallerClassesWithBlocksTest >> testExecutingAMethodWithASingleBlockBehavesCorrectly [

	| obj |
	obj := aClass new.
	self assert: obj aMethodWithABlock value equals: 42	

]

{ #category : #tests }
HEInstallerClassesWithBlocksTest >> testExecutingAMethodWithNestedBlocksBehavesCorrectly [

	| obj |
	
	obj := aClass new.
	self assert: obj aMethodWithNestedBlocks equals: 42

]

{ #category : #tests }
HEInstallerClassesWithBlocksTest >> testExecutingAMethodWithNestedBlocksExecutesTheEnsure [

	| obj |
	
	obj := aClass new.
	obj aMethodWithNestedBlocks.
	self assert: obj passedTheEnsure

]
