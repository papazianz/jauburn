Class {
	#name : #MockUIManager,
	#superclass : #Object,
	#instVars : [
		'inputContents'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #initialization }
MockUIManager >> initialize [ 

	super initialize.
	^self
]

{ #category : #accessing }
MockUIManager >> inputContents [
	^ inputContents
]

{ #category : #accessing }
MockUIManager >> inputContents: anObject [
	inputContents := anObject
]
