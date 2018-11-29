Class {
	#name : #TraGtCoderMethodPatternStencil,
	#superclass : #GtCoderMethodPatternStencil,
	#category : #'Tracer-GToolkit-Core'
}

{ #category : #'api - instantiation' }
TraGtCoderMethodPatternStencil >> create [
	^ TraGtCoderMethodPatternElement new
		methodCoder: self methodCoder;
		margin: (BlInsets left: 5);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ]
]
