"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> GCD [
" Java:
public static int gcd(int p, int q) {
        if (q == 0) {
            return p;
        }
        return gcd(q, p % q);
    }
"
^'var gcd = function(p,q) { 
		if (q == 0) {
			return p; 
		} else { 
			return gcd(q, mod(p,q));
		} };
		var input1 = str(input("Enter first number: "));
		var input2 = str(input("Enter second number: "));
		var result = println(gcd(input1, input2));'
]

{ #category : #'as yet unclassified' }
JbSamplePrograms class >> NewtonsSquareRoot [
	"comment stating purpose of message"

^'var NewtonsSquareRoot = function(x) { 
		var epsilon = 0.000000000000001;
		var y = x;
		while(abs(y - x/y) > (epsilon * y)) {y = ((x/y + y)/2);};
		};
		var input = str(input("Enter number: "));
		var result = println(NewtonsSquareRoot(input);'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]
