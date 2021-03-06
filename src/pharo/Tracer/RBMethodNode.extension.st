Extension { #name : #RBMethodNode }

{ #category : #'*Tracer' }
RBMethodNode >> traCallers [
	^ self propertyAt: #traCallers
]

{ #category : #'*Tracer' }
RBMethodNode >> traInstall [
	| link |
	self traUninstall.
	link := MetaLink new
		metaObject: #node;
		selector: #traInvokeIn:;
		arguments: #(context);
		yourself.
	self propertyAt: #tra put: true.
	self propertyAt: #traMonitor put: Monitor new.
	"needs identity, as method hash is not considering selector"
	self
		propertyAt: #traCallers
		ifAbsentPut: [ Dictionary new
				at: #direct put: IdentitySet new;
				at: #indirect put: IdentitySet new;
				yourself ].
	self propertyAt: #traLink put: link.
	self link: link.
	self method reflectiveMethod compileAndInstallCompiledMethod.
	^ self method ast
]

{ #category : #'*Tracer' }
RBMethodNode >> traInvokeIn: aContext [
	| sender invoke |
	aContext isBlockContext
		ifTrue: [ ^ self ].
	sender := aContext.
	invoke := #direct.
	[ sender sender isNotNil
		and: [ sender sender method ~~ aContext method
				and:
					[ sender sender method ast traIsCovered not and: [ sender sender method traIsEntryPoint not and: [ sender sender method package == self method package ] ] ] ] ]
		whileTrue: [ sender method ast traIsCovered
				ifTrue: [ invoke := #indirect ].
			sender := sender sender ].
	self traMonitor
		critical: [ sender sender
				ifNotNil: [ sender sender method traIsEntryPoint
						ifTrue: [ (self traCallers at: invoke) add: sender sender method ] ] ]
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
RBMethodNode >> traUninstall [
	self removeProperty: #tra ifAbsent: [  ].
	self removeProperty: #traMonitor ifAbsent: [  ].
	self removeProperty: #traCallers ifAbsent: [  ].
	self
		propertyAt: #traLink
		ifPresent: [ :e | 
			self removeProperty: #traLink ifAbsent: [  ].
			self removeLink: e ]
		ifAbsent: [  ]
]
