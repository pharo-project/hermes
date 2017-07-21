baselines
baseline: spec
	<baseline>
	spec for: #common do: [ spec
		package: 'Hermes';
		package: 'Hermes-Tests-External-Package';
		package: 'Hermes-Ring' with: [ spec requires: #('core') ];
		package: 'Hermes-Tests' with: [ spec requires: #('core' 'Hermes-Tests-External-Package') ];

		group: 'core'
			with: #(Hermes);
		group: 'ring'
			with: #('Hermes-Ring');
		group: 'test'
			with: #('Hermes-Tests' 'Hermes-Tests-External-Package')
	]