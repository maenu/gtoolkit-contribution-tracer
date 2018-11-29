Extension { #name : #Dictionary }

{ #category : #'*Scoper-GToolkit' }
Dictionary >> scoGtHalfFor: aColor spawning: aBlock [
	^ BlElement new
		layout: BlLinearLayout vertical;
		addChild: ((self at: #direct) scoGtQuarterFor: aColor spawning: aBlock);
		addChild: ((self at: #indirect) scoGtQuarterFor: (aColor alpha: 0.5) spawning: aBlock);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'*Scoper-GToolkit' }
Dictionary >> scoGtWholeForTest: aColor forExample: anotherColor [
	^ BlElement new
		layout: BlLinearLayout horizontal;
		addChild: ((self collect: [ :e | e select: #isTestMethod ]) scoGtHalfFor: aColor spawning: [ :e | TestCase buildSuiteFromMethods: e ]);
		addChild:
			((self collect: [ :e | e select: [ :f | f methodClass methods anySatisfy: #isGTExampleMethod ] ])
				scoGtHalfFor: anotherColor
				spawning: [ :e | 
					GtExplicitExampleGroup new
						examples: (e flatCollect: #gtExamples);
						yourself ]);
		yourself
]
