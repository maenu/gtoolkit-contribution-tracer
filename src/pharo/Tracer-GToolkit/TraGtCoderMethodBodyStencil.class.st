Class {
	#name : #TraGtCoderMethodBodyStencil,
	#superclass : #GtCoderMethodBodyStencil,
	#category : #'Tracer-GToolkit-Core'
}

{ #category : #'api - instantiation' }
TraGtCoderMethodBodyStencil >> create [
	^ TraGtCoderMethodBodyElement new
		methodCoder: self methodCoder;
		margin: (BlInsets left: 5);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ]
]
