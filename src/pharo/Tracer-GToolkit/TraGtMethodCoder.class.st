Class {
	#name : #TraGtMethodCoder,
	#superclass : #GtMethodCoder,
	#category : #'Tracer-GToolkit-Core'
}

{ #category : #'initialize-release' }
TraGtMethodCoder >> initializeAddOns [
	super initializeAddOns.
	addOns addStyler: TraGtTraceBodyStyler new
]
