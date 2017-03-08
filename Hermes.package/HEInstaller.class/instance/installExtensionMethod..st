installing methods
installExtensionMethod: extensionMethod
	| aClass |
	aClass := self environment at: extensionMethod className.
	self rebuildMethod: extensionMethod into: aClass.