Class {
	#name : #TraGtTraceBodyStyler,
	#superclass : #GtCoderBodyStyler,
	#category : #'Tracer-GToolkit'
}

{ #category : #visiting }
TraGtTraceBodyStyler >> visitMethodNode: aNode [
	| position |
	super visitMethodNode: aNode.
	position := aNode arguments isEmpty
		ifTrue: [ aNode selector size ]
		ifFalse: [ aNode arguments last stop ].
	self
		styleFrom: position
		to: position
		with:
			{(BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ aNode traElement
						constraintsDo: [ :c | 
							c horizontal exact: 32.
							c vertical exact: 32.
							self flag: 'its not possible to be higher than line though' ];
						margin:
							(BlInsets
								top: 0
								right: 2
								bottom: 0
								left: 2) ];
				yourself)}
]
