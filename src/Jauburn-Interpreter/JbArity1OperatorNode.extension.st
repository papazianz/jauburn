Extension { #name : #JbArity1OperatorNode }

{ #category : #'*Jauburn-Interpreter' }
JbArity1OperatorNode >> evaluateIn: environment [
	"comment stating purpose of message"

	| opValue |
	opValue := self operand evaluateIn: environment.
	self operator = $-
		ifTrue: [ ^0 - opValue ].
]
