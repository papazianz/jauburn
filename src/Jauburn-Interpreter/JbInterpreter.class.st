"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'transcript',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [ 

	^#abs -> [ :x | x abs ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [ 
	
	^ #concat -> [ :x :y | x,y ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [
	super initialize.
	environment := JbEnvironment new.
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :x | 
			| primBinding |
			primBinding := self perform: x.
			environment
				at: primBinding key
				put: (JbPrimitive new block: primBinding value) ]
]

{ #category : #primitives }
JbInterpreter >> inputBinding [ 

	 ^#input -> [ :prompt | self uimanager inputContents: prompt  ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [ 

	 ^#length -> [ :l | l size]
]

{ #category : #primitives }
JbInterpreter >> modBinding [ 

	^#mod -> [ :x :y | x \\ y ]
]

{ #category : #primitives }
JbInterpreter >> notBinding [

	^ #not -> [ :x | x not ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [

	^#print -> [ :value | (value isString) 
						ifTrue: [ self transcript show: value ] 
						ifFalse: [ self transcript show: value printString ]] 
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [ 

	^#println -> [ :value | (value isString) 
						ifTrue: [ self transcript show: value; cr] 
						ifFalse: [ self transcript show: value printString; cr]]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #accessing }
JbInterpreter >> transcript [
	^transcript ifNil: [ ^Transcript ]
]

{ #category : #accessing }
JbInterpreter >> transcript: anObject [
	transcript := anObject
]

{ #category : #accessing }
JbInterpreter >> uimanager [
	^ uimanager ifNil: [ UIManager default ]
]

{ #category : #accessing }
JbInterpreter >> uimanager: aUIManager [ 
	uimanager := aUIManager 
]
