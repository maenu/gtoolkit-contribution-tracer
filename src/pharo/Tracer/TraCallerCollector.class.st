Class {
	#name : #TraCallerCollector,
	#superclass : #Object,
	#instVars : [
		'invokeLink'
	],
	#category : #'Tracer-Core'
}

{ #category : #'as yet unclassified' }
TraCallerCollector >> collectIn: somePackages [
	| asts callers testResult |
	"assumes examples, tests, and model are not mixed"
	asts := somePackages
		flatCollect: [ :e | 
			(e methods reject: [ :f | f methodClass traIsEntryPoint ])
				collect: [ :f | 
					| ast |
					ast := f ast.
					self installOn: ast.
					ast ] ].
	testResult := TestResult new.
	"needs identity, as method hash is not considering selector"
	callers := IdentityDictionary new.
	[ somePackages
		do: [ :e | 
			e gtExamplesContained do: #run.
			(e definedClasses select: [ :f | f isTestCase and: f isAbstract not ]) do: [ :f | f suite run: testResult ] ] ]
		ensure: [ asts
				do: [ :e | 
					callers at: e method put: e traCallers.
					self uninstallFrom: e ] ].
	^ testResult -> callers
]

{ #category : #initialization }
TraCallerCollector >> initialize [
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
	aNode link: invokeLink.
	aNode method reflectiveMethod compileAndInstallCompiledMethod.
	^ aNode method ast
]

{ #category : #'as yet unclassified' }
TraCallerCollector >> uninstallFrom: aNode [
	aNode traUninstall.
	aNode removeProperty: #tra ifAbsent: [  ].
	aNode removeProperty: #traMonitor ifAbsent: [  ].
	aNode removeLink: invokeLink
]
