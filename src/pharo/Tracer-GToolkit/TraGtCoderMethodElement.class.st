Class {
	#name : #TraGtCoderMethodElement,
	#superclass : #GtCoderMethodElement,
	#category : #'Tracer-GToolkit-Core'
}

{ #category : #accessing }
TraGtCoderMethodElement >> methodCoder: aGtMethodCoder [
	super methodCoder: aGtMethodCoder.
	self header: [ TraGtCoderMethodPatternStencil new methodCoder: self methodCoder ].
	self content: [ TraGtCoderMethodBodyStencil new methodCoder: self methodCoder ]
]
