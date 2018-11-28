Class {
	#name : #TraCallerCollector,
	#superclass : #Object,
	#instVars : [
		'invokeLink',
		'callers',
		'root'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Tracer-Core'
}

{ #category : #'as yet unclassified' }
TraCallerCollector >> callers [
	^ callers
]

{ #category : #'as yet unclassified' }
TraCallerCollector >> collectAll: aCollection doing: aBlock [
	| asts |
	asts := aCollection
		collect: [ :e | 
			| ast |
			ast := e ast.
			self installOn: ast.
			ast ].
	^ [ aBlock value ]
		ensure: [ asts collect: [ :e | callers at: e methodClass name asSymbol -> e selector put: e traCallers ].
			asts do: [ :e | self uninstallFrom: e ] ]
]

{ #category : #initialization }
TraCallerCollector >> initialize [
	callers := Dictionary new.
	root := self class name asSymbol -> #collectAll:doing:.
	invokeLink := MetaLink new
		metaObject: #node;
		selector: #traInvokeIn:;
		arguments: #(context)
]

{ #category : #'as yet unclassified' }
TraCallerCollector >> install: aMetaLink on: aNode [
	aNode propertyAt: #tra put: true.
	aNode propertyAt: #traMonitor put: Monitor new.
	aNode propertyAt: #traRoot put: root.
	aNode link: aMetaLink
]

{ #category : #'as yet unclassified' }
TraCallerCollector >> installOn: aNode [
	aNode traUninstall.
	aNode do: [ :n | self install: invokeLink on: n ].
	aNode method reflectiveMethod compileAndInstallCompiledMethod.
	^ aNode method ast
]

{ #category : #'as yet unclassified' }
TraCallerCollector >> uninstallFrom: aNode [
	aNode removeProperty: #tra ifAbsent: [  ].
	aNode traUninstall.
	aNode removeLink: invokeLink
]
