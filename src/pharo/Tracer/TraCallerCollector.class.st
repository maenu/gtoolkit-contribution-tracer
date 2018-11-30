Class {
	#name : #TraCallerCollector,
	#superclass : #Object,
	#category : #'Tracer-Core'
}

{ #category : #'as yet unclassified' }
TraCallerCollector >> collectIn: somePackages [
	| asts callers testResult |
	"assumes examples, tests, and model are not mixed"
	asts := somePackages flatCollect: [ :e | (e methods reject: [ :f | f methodClass traIsEntryPoint ]) collect: [ :f | f ast traInstall ] ].
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
					e traUninstall ] ].
	^ testResult -> callers
]
