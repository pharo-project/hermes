I represent an element that can be exported and imported from a HeBinaryReaderWriter  that wrappes an Hermes file.

The class side implements #readFrom: method that is implemented in the subclasses and it is used to read an object independently of its type. 
The format is capable of detect the type of the object stored. 
This is implemented as all the subclasses implements the instance side method #readFrom:  that receives a HEBinaryReaderWriter

Also all the subclasses implements the instance side method #writeInto: that receives a HEBinaryReaderWriter and it is responsible of storing the object in a Hermes File. 