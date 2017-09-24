I represent all the exported literals. 

The exported literal subclasses should implement the classside #tag method to return an unique SmallInteger that represents its type. This is used to identify the literal that is exported.

The subclasses implements the required #doReadFrom: and #doWriteInto: to perform the reading and writting of the values. 

Also it implemnets the #value and #value: to access the literal value as it is in the image. 

The classside #for: method is used to create a new instance from an image value.

Also the subclasses implement the method #asLiterailIn: anEnvironment to answer the literal values that changes with the environment as classes, globals or class variables.