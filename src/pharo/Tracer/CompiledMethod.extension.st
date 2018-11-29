Extension { #name : #CompiledMethod }

{ #category : #'*Tracer' }
CompiledMethod >> traIsEntryPoint [
	^ self isTestMethod or: [ self isGTExampleMethod ]
]

{ #category : #'*Tracer' }
CompiledMethod >> traRunAsEntryPoint [
	self assert: [ self traIsEntryPoint ].
	self isTestMethod
		ifTrue: [ ^ self methodClass run: self selector ].
	self isGTExampleMethod
		ifTrue: [ ^ self gtExampleValue ]
]
