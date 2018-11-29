Extension { #name : #IdentitySet }

{ #category : #'*Tracer-GToolkit' }
IdentitySet >> traGtQuarterFor: aColor spawning: aBlock [
	^ BlElement new
		geometry: BlRectangle new;
		background: (self ifEmpty: [ aColor alpha: 0 ] ifNotEmpty: [ aColor ]);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		when: BlMouseDownEvent
			do: [ :e | 
			e target
				fireEvent:
					(GtPhlowObjectToSpawn new
						object: (aBlock cull: self);
						sourceElement: e target) ];
		yourself
]
