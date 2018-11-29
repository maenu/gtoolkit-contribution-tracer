Class {
	#name : #ScoGtMethodCoder,
	#superclass : #GtMethodCoder,
	#category : #'Scoper-GToolkit-Core'
}

{ #category : #elements }
ScoGtMethodCoder >> asElement [
	self ensureBuilt.
	^ ScoGtCoderMethodElement new
		margin: (BlInsets all: 10);
		methodCoder: self;
		yourself
]
