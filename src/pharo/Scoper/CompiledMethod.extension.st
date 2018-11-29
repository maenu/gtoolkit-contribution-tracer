Extension { #name : #CompiledMethod }

{ #category : #'*Scoper' }
CompiledMethod >> scoIsEntryPoint [
	^ self isTestMethod or: [ self isGTExampleMethod ]
]

{ #category : #'*Scoper' }
CompiledMethod >> scoRunAsEntryPoint [
	self assert: [ self scoIsEntryPoint ].
	self isTestMethod
		ifTrue: [ ^ self methodClass run: self selector ].
	self isGTExampleMethod
		ifTrue: [ ^ self gtExampleValue ]
]
