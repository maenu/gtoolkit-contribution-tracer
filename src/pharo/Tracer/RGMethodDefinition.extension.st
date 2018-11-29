Extension { #name : #RGMethodDefinition }

{ #category : #'*Tracer' }
RGMethodDefinition >> traIsEntryPoint [
	^ self compiledMethod traIsEntryPoint
]

{ #category : #'*Tracer' }
RGMethodDefinition >> traRunAsEntryPoint [
	^ self compiledMethod traRunAsEntryPoint
]
