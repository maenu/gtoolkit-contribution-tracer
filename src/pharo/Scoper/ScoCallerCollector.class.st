Class {
	#name : #ScoCallerCollector,
	#superclass : #Object,
	#instVars : [
		'invokeLink'
	],
	#category : #'Scoper-Core'
}

{ #category : #'as yet unclassified' }
ScoCallerCollector >> collectIn: somePackages [
	| asts callers testResult |
	"assumes examples, tests, and model are not mixed"
	asts := somePackages
		flatCollect: [ :e | 
			(e methods reject: [ :f | f methodClass scoIsEntryPoint ])
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
					callers at: e method put: e scoCallers.
					self uninstallFrom: e ] ].
	^ testResult -> callers
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
