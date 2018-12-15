Class {
	#name : #TraGtCoderMethodBodyElement,
	#superclass : #GtCoderMethodBodyElement,
	#instVars : [
		'scoper'
	],
	#category : #'Tracer-GToolkit-Core'
}

{ #category : #initialization }
TraGtCoderMethodBodyElement >> initialize [
	super initialize.
	self layout: (BlGridLayout new columnCount: 2)
]

{ #category : #accessing }
TraGtCoderMethodBodyElement >> methodCoder: aMethodCoder [
	methodCoder := aMethodCoder.
	self
		addChild:
			(self scoper
				constraintsDo: [ :c | 
					c horizontal exact: 16.
					c vertical exact: 16.
					self flag: 'its not possible to be higher than line though' ];
				margin: (BlInsets right: 5)).
	self
		addChild:
			(self breadcrumb
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent ]).
	self
		addChild:
			(self editorElement
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent.
					c grid horizontal span: 2 ])
		as: #bodyElement.
	self actionsElement ifNotNil: [ :e | self addChild: (e constraintsDo: [ :c | c grid horizontal span: 2 ]) ]
]

{ #category : #accessing }
TraGtCoderMethodBodyElement >> scoper [
	^ [ [ (TraResolver instance resolveMethod: methodCoder classOrMetaClass >> methodCoder selector)
		traGtWholeForTest: Color purple lighter
		forExample: Color orange lighter ]
		on: TraNoPackageFoundError
		do: [ BlElement new ] ]
		on: TraNoMethodFoundError
		do: [ BlElement new ]
]
