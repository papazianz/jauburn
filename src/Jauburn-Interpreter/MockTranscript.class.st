"
a comment

"
Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'transcriptContents'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #accessing }
MockTranscript >> contents [

	^transcriptContents contents
]

{ #category : #accessing }
MockTranscript >> contents: anObject [ 

	transcriptContents := anObject
]

{ #category : #'stop conditions' }
MockTranscript >> cr [ 

	transcriptContents nextPut: Character cr
]

{ #category : #initialization }
MockTranscript >> initialize [ 

	transcriptContents := String new writeStream.
]

{ #category : #streaming }
MockTranscript >> show: anObject [ 

	^transcriptContents nextPutAll: anObject 
]
