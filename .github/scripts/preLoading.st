"Remove Hermes from system (so I can reload it).
RPackageOrganizer was renamed PackageOrganizer in Pharo 12 and the old name was removed in Pharo 13."
((Smalltalk globals at: #PackageOrganizer ifAbsent: [ Smalltalk globals at: #RPackageOrganizer ]) default packages select: [ :package | package name beginsWith: 'Hermes' ]) do: [ :package | package removeFromSystem ].
