Class {
	#name : #ScoGtCoderMethodPatternStencil,
	#superclass : #GtCoderMethodPatternStencil,
	#category : #'Scoper-GToolkit-Core'
}

{ #category : #'api - instantiation' }
ScoGtCoderMethodPatternStencil >> create [
	^ ScoGtCoderMethodPatternElement new
		methodCoder: self methodCoder;
		margin: (BlInsets left: 5);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ]
]
