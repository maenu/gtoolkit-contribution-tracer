Class {
	#name : #ScoGtCoderMethodPatternElement,
	#superclass : #GtCoderMethodPatternElement,
	#instVars : [
		'scoper'
	],
	#category : #'Scoper-GToolkit-Core'
}

{ #category : #initialization }
ScoGtCoderMethodPatternElement >> initialize [
	super initialize.
	self layout: (BlGridLayout new columnCount: 2).
	scoper := BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 25.
			c vertical matchParent.
			c grid vertical span: 2 ];
		margin: (BlInsets right: 5);
		yourself.
	breadcrumb
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	label
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	self addChild: scoper at: 1
]

{ #category : #accessing }
ScoGtCoderMethodPatternElement >> methodCoder: aMethodCoder [
	super methodCoder: aMethodCoder.
	[ | callers |
	callers := (ScoResolver instance resolveMethod: aMethodCoder classOrMetaClass >> aMethodCoder selector) value.
	scoper
		removeChildren;
		addChild:
			((callers scoGtWholeForTest: Color purple forExample: Color orange)
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				yourself) ]
		on: Error
		do: [ :e | e return ]
]
