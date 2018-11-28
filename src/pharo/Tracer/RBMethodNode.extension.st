Extension { #name : #RBMethodNode }

{ #category : #'*Tracer' }
RBMethodNode >> traCallers [
	^ self propertyAt: #traCallers ifAbsentPut: [ Set new ]
]

{ #category : #'*Tracer' }
RBMethodNode >> traInvokeIn: aContext [
	| sender |
	aContext isBlockContext
		ifTrue: [ ^ self ].
	sender := aContext.
	[ sender sender isNotNil
		and: [ sender sender method ~~ aContext method and: [ sender sender method ast traIsCovered not and: [ sender sender method traIsEntryPoint not ] ] ] ]
		whileTrue: [ sender := sender sender ].
	self traMonitor
		critical: [ sender sender
				ifNil: [ self traCallers add: self traRoot ]
				ifNotNil: [ | method |
					method := sender sender method.
					self traCallers add: method methodClass name asSymbol -> method selector ] ]
]

{ #category : #'*Tracer' }
RBMethodNode >> traIsCovered [
	^ self hasProperty: #tra
]

{ #category : #'*Tracer' }
RBMethodNode >> traMonitor [
	^ self propertyAt: #traMonitor
]

{ #category : #'*Tracer' }
RBMethodNode >> traRoot [
	^ self propertyAt: #traRoot
]

{ #category : #'*Tracer' }
RBMethodNode >> traUninstall [
	self removeProperty: #traCallers ifAbsent: [  ]
]
