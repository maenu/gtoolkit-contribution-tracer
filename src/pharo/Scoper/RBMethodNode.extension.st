Extension { #name : #RBMethodNode }

{ #category : #'*Scoper' }
RBMethodNode >> scoCallers [
	"needs identity, as method hash is not considering selector"

	^ self
		propertyAt: #scoCallers
		ifAbsentPut: [ Dictionary new
				at: #direct put: IdentitySet new;
				at: #indirect put: IdentitySet new;
				yourself ]
]

{ #category : #'*Scoper' }
RBMethodNode >> scoInvokeIn: aContext [
	| sender invoke |
	aContext isBlockContext
		ifTrue: [ ^ self ].
	sender := aContext.
	invoke := #direct.
	[ sender sender isNotNil and: [ sender sender method ~~ aContext method and: [ sender sender method ast scoIsCovered not and: [ sender sender method scoIsEntryPoint not ] ] ] ]
		whileTrue: [ sender method ast scoIsCovered
				ifTrue: [ invoke := #indirect ].
			sender := sender sender ].
	self scoMonitor
		critical: [ sender sender method scoIsEntryPoint
				ifTrue: [ (self scoCallers at: invoke) add: sender sender method ] ]
]

{ #category : #'*Scoper' }
RBMethodNode >> scoIsCovered [
	^ self hasProperty: #sco
]

{ #category : #'*Scoper' }
RBMethodNode >> scoMonitor [
	^ self propertyAt: #scoMonitor
]

{ #category : #'*Scoper' }
RBMethodNode >> scoUninstall [
	self removeProperty: #scoCallers ifAbsent: [  ]
]
