"Remove Hermes from system (so I can reload it)"
(RPackageOrganizer default packages select: [:package | package name beginsWith: 'Hermes']) do: [:package | package removeFromSystem ].