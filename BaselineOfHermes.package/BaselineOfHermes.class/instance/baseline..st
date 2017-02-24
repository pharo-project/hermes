baselines
baseline: spec
	<baseline>
	spec for: #common do: [ spec
		package: 'Hermes';
		package: 'Hermes-Tests' with: [ spec requires: #(core) ];

		group: 'core'
			with: #(Hermes);
		group: 'test'
			with: #('Hermes-Tests')
	]