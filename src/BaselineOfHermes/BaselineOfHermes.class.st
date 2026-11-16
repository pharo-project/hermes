Class {
	#name : 'BaselineOfHermes',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfHermes',
	#package : 'BaselineOfHermes'
}

{ #category : 'baselines' }
BaselineOfHermes >> baseline: spec [

	<baseline>
	spec for: #common do: [
			self pharoBackwardCompatibility: spec.

			spec
				package: 'Hermes' with: [ spec requires: #( 'PharoBackwardCompatibility' ) ];
				package: 'Hermes-Exporter' with: [ spec requires: #( 'Hermes' ) ];
				package: 'Hermes-Extensions' with: [ spec requires: #( 'Hermes' ) ];
				package: 'Hermes-Ring2' with: [ spec requires: #( 'Hermes-Exporter' ) ];
				package: 'Hermes-Tests-Classes';
				package: 'Hermes-Tests-External-Package';
				package: 'Hermes-Tests' with: [ spec requires: #( 'core' 'Hermes-Tests-Classes' 'Hermes-Tests-External-Package' ) ];
				package: 'Hermes-Tests-Ring' with: [ spec requires: #( 'core' 'Hermes-Tests-External-Package' ) ];
				group: 'core' with: #( 'Hermes' 'Hermes-Exporter' 'Hermes-Extensions' 'Hermes-Ring2' );
				group: 'minimal' with: #( 'Hermes' );
				group: 'test' with: #( 'Hermes-Tests' 'Hermes-Tests-Classes' 'Hermes-Tests-External-Package' ) ].

	spec for: (self pharoVersionsUpTo: 13) do: [
			spec
				package: 'Hermes-CommandLineHandler' with: [ spec requires: #( 'Hermes-Extensions' ) ];
				package: 'Hermes-CommandLineHandler-Tests' with: [ spec requires: #( 'Hermes-CommandLineHandler' ) ];
				group: 'core' with: #( 'Hermes-CommandLineHandler' );
				group: 'test' with: #( 'Hermes-CommandLineHandler-Tests' ) ].

	spec for: (self pharoVersionsFrom: 14) do: [
			spec
				package: 'Hermes-Clap' with: [ spec requires: #( 'Hermes-Extensions' ) ];
				package: 'Hermes-Clap-Tests' with: [ spec requires: #( 'Hermes-Clap' ) ];
				group: 'core' with: #( 'Hermes-Clap' );
				group: 'test' with: #( 'Hermes-Clap-Tests' ) ].

	spec for: (self pharoVersionsFrom: 11) do: [
			spec
				package: 'Hermes-Exporter' with: [ spec includes: #( 'Hermes-Exporter-Pharo11' ) ];
				package: 'Hermes-Exporter-Pharo11' ]
]

{ #category : 'dependencies' }
BaselineOfHermes >> pharoBackwardCompatibility: spec [

	spec baseline: 'PharoBackwardCompatibility' with: [ spec repository: 'github://jecisc/PharoBackwardCompatibility:v1.x.x/src' ]
]

{ #category : 'baselines' }
BaselineOfHermes >> pharoVersionsFrom: aVersion [
	^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]

{ #category : 'baselines' }
BaselineOfHermes >> pharoVersionsUpTo: aVersion [

	^ (10 to: (aVersion min: SystemVersion current major)) collect: [ :version | ('pharo' , version asString , '.x') asSymbol ]
]
