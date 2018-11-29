Extension { #name : #IdentitySet }

{ #category : #'*Scoper-GToolkit' }
IdentitySet >> scoGtQuarterFor: aColor [
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
						object: self;
						sourceElement: e target) ];
		yourself
]
