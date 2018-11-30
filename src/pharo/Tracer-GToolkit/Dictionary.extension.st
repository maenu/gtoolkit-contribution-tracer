Extension { #name : #Dictionary }

{ #category : #'*Tracer-GToolkit' }
Dictionary >> traGtHalfFor: aColor spawning: aBlock [
	^ BlElement new
		layout: BlLinearLayout vertical;
		addChild: ((self at: #direct) traGtQuarterFor: aColor spawning: aBlock);
		addChild: ((self at: #indirect) traGtQuarterFor: (aColor alpha: 0.5) spawning: aBlock);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'*Tracer-GToolkit' }
Dictionary >> traGtWholeForTest: aColor forExample: anotherColor [
	^ BlElement new
		layout: BlLinearLayout horizontal;
		addChild:
			((self collect: [ :e | e select: #isTestMethod ])
				traGtHalfFor: aColor
				spawning: [ :e | 
					| result suite |
					result := TestResult new.
					suite := TestSuite new.
					e do: [ :eachMethod | suite addTest: (eachMethod origin selector: eachMethod selector) ].
					[ suite run: result ] schedule.
					result ]);
		addChild:
			((self collect: [ :e | e select: [ :f | f methodClass methods anySatisfy: #isGTExampleMethod ] ])
				traGtHalfFor: anotherColor
				spawning: [ :e | 
					| group |
					group := GtExplicitExampleGroup new
						examples: (e flatCollect: #gtExamples);
						yourself.
					[ group runAll ] schedule.
					group ]);
		yourself
]
