Extension { #name : #RBMethodNode }

{ #category : #'*Tracer' }
RBMethodNode >> traCallers [
	"needs identity, as method hash is not considering selector"

	^ self
		propertyAt: #traCallers
		ifAbsentPut: [ Dictionary new
				at: #direct put: IdentitySet new;
				at: #indirect put: IdentitySet new;
				yourself ]
]

{ #category : #'*Tracer' }
RBMethodNode >> traInvokeIn: aContext [
	| sender invoke |
	aContext isBlockContext
		ifTrue: [ ^ self ].
	sender := aContext.
	invoke := #direct.
	[ sender sender isNotNil and: [ sender sender method ~~ aContext method and: [ sender sender method ast traIsCovered not and: [ sender sender method traIsEntryPoint not ] ] ] ]
		whileTrue: [ sender method ast traIsCovered
				ifTrue: [ invoke := #indirect ].
			sender := sender sender ].
	self traMonitor
		critical: [ sender sender method traIsEntryPoint
				ifTrue: [ (self traCallers at: invoke) add: sender sender method ] ]
]

{ #category : #'*Tracer' }
RBMethodNode >> traIsCovered [
	^ self hasProperty: #tra
]

{ #category : #'*Tracer' }
RBMethodNode >> traMonitor [
	^ self propertyAt: #traMonitor ifAbsentPut: [ Monitor new ]
]

{ #category : #'*Tracer' }
RBMethodNode >> traUninstall [
	self removeProperty: #traCallers ifAbsent: [  ]
]
