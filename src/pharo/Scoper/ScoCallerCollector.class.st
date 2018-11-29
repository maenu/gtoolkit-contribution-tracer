Class {
	#name : #ScoCallerCollector,
	#superclass : #Object,
	#instVars : [
		'invokeLink'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Scoper-Core'
}

{ #category : #'as yet unclassified' }
ScoCallerCollector >> collectAll: aPackage doing: aBlock [
	| classes asts callers |
	classes := aPackage definedClasses.
	classes do: [ :e | e methods detect: [ :f | f selector = #initialize ] ifNone: [ e compile: 'initialize <scoTemporary> ^ super initialize' ] ].
	asts := aPackage methods , (classes collect: [ :e | e >> #initialize ])
		collect: [ :e | 
			| ast |
			ast := e ast.
			self installOn: ast.
			ast ].
	"needs identity, as method hash is not considering selector"
	callers := IdentityDictionary new.
	[ aBlock value ]
		ensure: [ asts
				do: [ :e | 
					callers at: e method put: e scoCallers.
					self uninstallFrom: e ].
			classes do: [ :e | (e methods select: [ :f | f hasPragmaNamed: #scoTemporary ]) do: [ :f | e removeSelector: f selector ] ] ].
	^ callers
]

{ #category : #initialization }
ScoCallerCollector >> initialize [
	invokeLink := MetaLink new
		metaObject: #node;
		selector: #scoInvokeIn:;
		arguments: #(context)
]

{ #category : #'as yet unclassified' }
ScoCallerCollector >> installOn: aNode [
	aNode scoUninstall.
	aNode propertyAt: #sco put: true.
	aNode propertyAt: #scoMonitor put: Monitor new.
	aNode link: invokeLink.
	aNode method reflectiveMethod compileAndInstallCompiledMethod.
	^ aNode method ast
]

{ #category : #'as yet unclassified' }
ScoCallerCollector >> uninstallFrom: aNode [
	aNode scoUninstall.
	aNode removeProperty: #sco ifAbsent: [  ].
	aNode removeProperty: #scoMonitor ifAbsent: [  ].
	aNode removeLink: invokeLink
]
