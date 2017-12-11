processing files
processFiles
	(self commandLine allFilesWithExtension: '.hermes') do: [ :file | self processFile: file ]