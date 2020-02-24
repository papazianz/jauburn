Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> test1Operator [
	"comment stating purpose of message"

		self interpret: 'var x = 87;var y = -x;'.
		self assert: (interpreter environment at: 'y') equals: -87.
		
		self interpret: 'var x = -87;var y = -x;'.
		self assert: (interpreter environment at: 'y') equals: 87.
]

{ #category : #tests }
JbInterpreterTest >> test2OperatorBoolean [
	"comment stating purpose of message"
	self interpret: 'var x = 50 < 100;'.
	self assert: (interpreter environment at: 'x').
	
	self interpret: 'var x = 100 <= 100;'.
	self assert: (interpreter environment at: 'x').
	
	self interpret: 'var x = 1 >= 1;'.
	self assert: (interpreter environment at: 'x').
	
	self interpret: 'var x = 87 <= 100;'.
	self assert: (interpreter environment at: 'x').
	
	self interpret: 'var x = 2 >= 1;'.
	self assert: (interpreter environment at: 'x').
	
	self interpret: 'var x = 10 > 9;'.
	self assert: (interpreter environment at: 'x').
	
	self interpret: 'var x = 10 == 1;'.
	self deny: (interpreter environment at: 'x').
	
	self interpret: 'var x = true; var z = false;'.
	self assert: (interpreter environment at: 'z') equals: false.
		
	self interpret: 'var x = 100 == 100;'.
	self assert: (interpreter environment at: 'x').
	
	self interpret: 'var x = 1 ~= 2;'.
	self assert: (interpreter environment at: 'x').
	

	
	
]

{ #category : #tests }
JbInterpreterTest >> testAbsBinding [
	"comment stating purpose of message"

	self interpret: 'var x = abs(-10);'.
   self assert: (interpreter environment at: 'x') equals: 10.
]

{ #category : #tests }
JbInterpreterTest >> testConcatBinding [
	"comment stating purpose of message"

	self interpret: 'var x = concat("test", "123");'.
   self assert: (interpreter environment at: 'x') equals: 'test123'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 20 - 10 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 15.
	
	self interpret: 'var x = 5; var y = 25/x;'.
	self assert: (interpreter environment at: 'y') equals: 5.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testInputBinding [
	"comment stating purpose of message"
	| mui |
	mui := MockUIManager new.
	interpreter uimanager: mui.
	self interpret: 'var x = input("test");'.
	self assert: mui inputContents equals: 'test'.
	
]

{ #category : #tests }
JbInterpreterTest >> testJBFunction [
	"comment stating purpose of message"

	self interpret: 'var x = function(a, b, c) {return a + b - c;}; var y = x(1, 2, 3);'.
	self assert: (interpreter environment at: 'x') parameters size equals: 3.
	self assert: (interpreter environment at: 'x') body size equals: 1.
	self assert: (interpreter environment at: 'x') environment equals: interpreter environment.
	self assert: (interpreter environment at: 'y') equals: 0
]

{ #category : #tests }
JbInterpreterTest >> testLengthBinding [
	"comment stating purpose of message"

	self interpret: 'var x = length("123");'.
   self assert: (interpreter environment at: 'x') equals: 3.
]

{ #category : #tests }
JbInterpreterTest >> testModBinding [
	"comment stating purpose of message"

	self interpret: 'var x = mod(10,3);'.
   self assert: (interpreter environment at: 'x') equals: 1.
]

{ #category : #tests }
JbInterpreterTest >> testNotBinding [
	"comment stating purpose of message"

	self interpret: 'var y = true; var x = not(y);'.
   self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testPrintBinding [
	"comment stating purpose of message"
	| mt |
	mt := MockTranscript new.
	interpreter transcript: mt. 
	interpreter run: 'var x = print("test");'.
   self assert: mt contents equals: 'test'.
]

{ #category : #tests }
JbInterpreterTest >> testPrintlnBinding [
	"comment stating purpose of message"
	| mt |
	mt := MockTranscript new.
	interpreter transcript: mt. 
	interpreter run: 'var x = println("test");'.
   self assert: mt contents equals: 'test
'.
]

{ #category : #tests }
JbInterpreterTest >> testWhile [ 	

	self interpret: 'var x = 0;var y = 0;while(x < 11) {y = y + x; x = x + 1;}'.
	self assert: (interpreter environment at: 'y') equals: 55.
]
