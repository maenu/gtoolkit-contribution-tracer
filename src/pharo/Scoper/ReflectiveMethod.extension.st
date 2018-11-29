Extension { #name : #ReflectiveMethod }

{ #category : #'*Scoper' }
ReflectiveMethod >> scoIsEntryPoint [
	^ self compiledMethod scoIsEntryPoint
]

{ #category : #'*Scoper' }
ReflectiveMethod >> scoRunAsEntryPoint [
	^ self compiledMethod scoRunAsEntryPoint
]
