Class {
	#name : 'HECommandLineHandlerTest',
	#superclass : 'TestCase',
	#category : 'Hermes-Tests',
	#package : 'Hermes-Tests'
}

{ #category : 'tests' }
HECommandLineHandlerTest >> testDuplicationModeDefault [
	| handler installer |
	handler := HermesCommandLineHandler new.
	handler commandLine: (CommandLineArguments withArguments: #('prb.hermes')).
	
	installer := handler createInstaller.
	self assert: (installer instVarNamed: #duplicationMode) class equals: HEFailOnDuplication.
]

{ #category : 'tests' }
HECommandLineHandlerTest >> testDuplicationModeFail [
	| handler installer |
	handler := HermesCommandLineHandler new.
	handler commandLine: (CommandLineArguments withArguments: #('prb.hermes' '--on-duplication=fail')).
	
	installer := handler createInstaller.
	self assert: (installer instVarNamed: #duplicationMode) class equals: HEFailOnDuplication.
]

{ #category : 'tests' }
HECommandLineHandlerTest >> testDuplicationModeIgnore [
	| handler installer |
	handler := HermesCommandLineHandler new.
	handler commandLine: (CommandLineArguments withArguments: #('prb.hermes' '--on-duplication=ignore')).
	
	installer := handler createInstaller.
	self assert: (installer instVarNamed: #duplicationMode) class equals: HEIgnoreOnDuplication.
]

{ #category : 'tests' }
HECommandLineHandlerTest >> testDuplicationModeReplace [
	| handler installer |
	handler := HermesCommandLineHandler new.
	handler commandLine: (CommandLineArguments withArguments: #('prb.hermes' '--on-duplication=replace')).
	
	installer := handler createInstaller.
	self assert: (installer instVarNamed: #duplicationMode) class equals: HEReplaceOnDuplication.
]

{ #category : 'tests' }
HECommandLineHandlerTest >> testFailOnNewUndeclared [
	| handler installer |
	handler := HermesCommandLineHandler new.
	handler commandLine: (CommandLineArguments withArguments: #(prb.hermes)).
	
	installer := handler createInstaller.
	self assert: (installer instVarNamed: #failOnUndeclared) equals: true
]

{ #category : 'tests' }
HECommandLineHandlerTest >> testNoFailOnNewUndeclared [
	| handler installer |
	handler := HermesCommandLineHandler new.
	handler commandLine: (CommandLineArguments withArguments: #('prb.hermes' '--no-fail-on-undeclared')).
	
	installer := handler createInstaller.
	self assert: (installer instVarNamed: #failOnUndeclared) equals: false
]

{ #category : 'tests' }
HECommandLineHandlerTest >> testValidateFiles [
	| handler |
	handler := HermesCommandLineHandler new.
	handler commandLine: (CommandLineArguments withArguments: #()).
	
	self should:[handler validate] raise:Exception.
]
