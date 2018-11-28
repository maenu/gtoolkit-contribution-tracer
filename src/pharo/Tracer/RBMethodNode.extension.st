Extension { #name : #RBMethodNode }

{ #category : #'*Tracer' }
RBMethodNode >> traCallers [
	"needs identity, as method hash is not considering selector"
	^ self propertyAt: #traCallers ifAbsentPut: [ IdentitySet new ]
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
	self traMonitor critical: [ sender sender ifNil: [ self traCallers add: self traRoot ] ifNotNil: [ self traCallers add: sender sender method ] ]
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
