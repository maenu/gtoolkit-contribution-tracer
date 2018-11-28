Class {
	#name : #TraCallerCollector,
	#superclass : #Object,
	#instVars : [
		'invokeLink',
		'root'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Tracer-Core'
}

{ #category : #'as yet unclassified' }
TraCallerCollector >> collectAll: aCollection doing: aBlock [
	| asts callers |
	asts := aCollection
		collect: [ :e | 
			| ast |
			ast := e ast.
			self installOn: ast.
			ast ].
	"needs identity, as method hash is not considering selector"
	callers := IdentityDictionary new.
	[ aBlock value ]
		ensure: [ asts collect: [ :e | callers at: e method put: e traCallers ].
			asts do: [ :e | self uninstallFrom: e ] ].
	^ callers
]

{ #category : #initialization }
TraCallerCollector >> initialize [
	root := self class >> #collectAll:doing:.
	invokeLink := MetaLink new
		metaObject: #node;
		selector: #traInvokeIn:;
		arguments: #(context)
]

{ #category : #'as yet unclassified' }
TraCallerCollector >> installOn: aNode [
	aNode traUninstall.
	aNode propertyAt: #tra put: true.
	aNode propertyAt: #traMonitor put: Monitor new.
	aNode propertyAt: #traRoot put: root.
	aNode link: invokeLink.
	aNode method reflectiveMethod compileAndInstallCompiledMethod.
	^ aNode method ast
]

{ #category : #'as yet unclassified' }
TraCallerCollector >> uninstallFrom: aNode [
	aNode traUninstall.
	aNode removeProperty: #tra ifAbsent: [  ].
	aNode removeProperty: #traMonitor ifAbsent: [  ].
	aNode removeProperty: #traRoot ifAbsent: [  ].
	aNode removeLink: invokeLink
]
