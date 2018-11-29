Extension { #name : #RGMethodDefinition }

{ #category : #'*Scoper' }
RGMethodDefinition >> scoIsEntryPoint [
	^ self compiledMethod scoIsEntryPoint
]

{ #category : #'*Scoper' }
RGMethodDefinition >> scoRunAsEntryPoint [
	^ self compiledMethod scoRunAsEntryPoint
]
