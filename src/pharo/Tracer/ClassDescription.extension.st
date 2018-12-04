Extension { #name : #ClassDescription }

{ #category : #'*Tracer' }
ClassDescription >> traIsEntryPoint [
	^ self methods anySatisfy: #traIsEntryPoint
]
