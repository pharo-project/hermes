initialization
initialize
	version := self class formatVersion.
	classes := OrderedCollection new.
	extensionMethods := OrderedCollection new.
	imageVersion := SystemVersion current highestUpdate.
