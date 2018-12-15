Class {
	#name : #TraGtMethodCoder,
	#superclass : #GtMethodCoder,
	#category : #'Tracer-GToolkit-Core'
}

{ #category : #elements }
TraGtMethodCoder >> asElement [
	self ensureBuilt.
	^ TraGtCoderMethodElement new
		methodCoder: self;
		yourself
]
