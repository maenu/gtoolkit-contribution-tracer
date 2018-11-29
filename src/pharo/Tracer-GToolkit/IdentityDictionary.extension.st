Extension { #name : #IdentityDictionary }

{ #category : #'*Tracer-GToolkit' }
IdentityDictionary >> traGtAddClasses: aDictionary to: aView shaped: aBlock colored: aColor [
	aView nodes
		shape: [ :x | 
			BlElement new
				geometry: BlRectangle new;
				background: (aColor alpha: 0.1);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent.
					c padding: (BlInsets all: 25) ];
				yourself ];
		with: {aDictionary}
			forEach: [ :e | 
			aView nodes
				shape: [ :y | 
					BlElement new
						geometry: BlRectangle new;
						background: (aColor alpha: 0.25);
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent.
							c padding: (BlInsets all: 25) ];
						yourself ];
				with: e keys
					forEach: [ :f | 
					aView nodes
						shape: [ :y | 
							(aBlock value: y)
								background: (aColor alpha: 0.5);
								yourself ];
						with: (e at: f).
					aView layout grid ].
			aView layout custom: BlLinearLayout horizontal ]
]

{ #category : #'*Tracer-GToolkit' }
IdentityDictionary >> traGtEntryPointsSatisfying: aBlock [
	^ ((self values flatCollect: #values) flatCollect: #yourself) select: aBlock
]

{ #category : #'*Tracer-GToolkit' }
IdentityDictionary >> traGtGroupedByClass: aSet [
	^ aSet
		inject: IdentityDictionary new
		into: [ :e :b | 
			| methods |
			methods := e at: b methodClass ifAbsentPut: [ IdentitySet new ].
			methods add: b.
			e ]
]

{ #category : #'*Tracer-GToolkit' }
IdentityDictionary >> traGtViewFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Call Graph (Scoper)' translated;
		priority: 50;
		painting: [ :view | 
			| subjectColor testColor exampleColor subjectClasses testClasses exampleClasses |
			subjectColor := Color veryLightGray.
			testColor := Color purple lighter.
			exampleColor := Color orange lighter.
			subjectClasses := self traGtGroupedByClass: self keys.
			testClasses := self traGtGroupedByClass: (self traGtEntryPointsSatisfying: [ :e | e methodClass isTestCase ]).
			exampleClasses := self traGtGroupedByClass: (self traGtEntryPointsSatisfying: [ :e | e methodClass methods anySatisfy: #isGTExampleMethod ]).
			self
				traGtAddClasses: testClasses
				to: view
				shaped: [ :x | 
					BlElement new
						geometry: BlRectangle new;
						yourself ]
				colored: (testColor alpha: 0.25).
			self
				traGtAddClasses: subjectClasses
				to: view
				shaped: [ :x | 
					((self at: x) traGtWholeForTest: testColor forExample: exampleColor)
						constraintsDo: [ :c | 
							c
								padding:
									(BlInsets
										top: 17
										left: 0
										bottom: 0
										right: 0) ] ]
				colored: (subjectColor alpha: 0.25).
			self
				traGtAddClasses: exampleClasses
				to: view
				shaped: [ :x | 
					BlElement new
						geometry: BlRectangle new;
						yourself ]
				colored: (exampleColor alpha: 0.25).
			view edges
				shape: [ :x | BlLineElement new border: (BlBorder paint: (exampleColor alpha: 0.25) width: 5) ];
				connect:
					(self associations
						flatCollect: [ :e | ((e value at: #direct) select: [ :f | f methodClass methods anySatisfy: #isGTExampleMethod ]) collect: [ :f | f -> e key ] ])
					from: #key
					to: #value.
			view edges
				shape: [ :x | 
					BlLineElement new
						border:
							(BlBorder builder
								paint: (exampleColor alpha: 0.1);
								width: 5;
								dashed;
								build) ];
				connect:
					(self associations
						flatCollect: [ :e | ((e value at: #indirect) select: [ :f | f methodClass methods anySatisfy: #isGTExampleMethod ]) collect: [ :f | f -> e key ] ])
					from: #key
					to: #value.
			view edges
				shape: [ :x | BlLineElement new border: (BlBorder paint: (testColor alpha: 0.25) width: 5) ];
				connect: (self associations flatCollect: [ :e | ((e value at: #direct) select: #isTestMethod) collect: [ :f | f -> e key ] ]) from: #key to: #value.
			view edges
				shape: [ :x | 
					BlLineElement new
						border:
							(BlBorder builder
								paint: (testColor alpha: 0.1);
								width: 5;
								dashed;
								build) ];
				connect: (self associations flatCollect: [ :e | ((e value at: #indirect) select: #isTestMethod) collect: [ :f | f -> e key ] ]) from: #key to: #value.
			view layout vertical ]
]
