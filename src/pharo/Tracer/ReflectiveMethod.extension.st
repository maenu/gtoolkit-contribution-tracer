Extension { #name : #ReflectiveMethod }

{ #category : #'*Tracer' }
ReflectiveMethod >> traIsEntryPoint [
	^ self compiledMethod traIsEntryPoint
]

{ #category : #'*Tracer' }
ReflectiveMethod >> traRunAsEntryPoint [
	^ self compiledMethod traRunAsEntryPoint
]
