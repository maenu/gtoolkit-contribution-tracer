Class {
	#name : #ScoGtCoderMethodElement,
	#superclass : #GtCoderMethodElement,
	#category : #'Scoper-GToolkit'
}

{ #category : #accessing }
ScoGtCoderMethodElement >> methodCoder: aGtMethodCoder [
	super methodCoder: aGtMethodCoder.
	self header: [ ScoGtCoderMethodPatternStencil new methodCoder: self methodCoder ]
]
