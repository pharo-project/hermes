installing methods
installMethods: exportedClass into: aClass
	exportedClass methods do: [ :e | self rebuildMethod: e into: aClass from: exportedClass ].
	exportedClass classSideMethods
		do: [ :e | self rebuildMethod: e into: aClass theMetaClass from: exportedClass ]