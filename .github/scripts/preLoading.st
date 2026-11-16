"Remove Hermes from system (so I can reload it).
RPackageOrganizer was renamed PackageOrganizer in Pharo 12 and the old name was removed in Pharo 13."
| hermesPackages |
hermesPackages := (Smalltalk globals at: #PackageOrganizer ifAbsent: [ Smalltalk globals at: #RPackageOrganizer ]) default packages select: [ :package | package name beginsWith: 'Hermes' ].

"Since Pharo 14, the command line commands are found from a cache of the <commandline> pragmas, which keeps the methods of removed classes while something references them (Clap-Tests references HermesClapCommand in Pharo 14). We remove these methods first so that the command of Pharo does not conflict with the one we load."
(Pragma allNamed: #commandline) do: [ :pragma |
	(hermesPackages includes: pragma method package) ifTrue: [ pragma method methodClass removeSelector: pragma method selector ] ].

hermesPackages do: [ :package | package removeFromSystem ]
