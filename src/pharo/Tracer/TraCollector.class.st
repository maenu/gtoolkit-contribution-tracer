Class {
	#name : #TraCollector,
	#superclass : #Object,
	#category : #'Tracer-Core'
}

{ #category : #'as yet unclassified' }
TraCollector >> collectIn: somePackages [
	| asts callers testResult exampleResults |
	"assumes examples, tests, and model are not mixed"
	asts := somePackages flatCollect: [ :e | (e methods reject: [ :f | f methodClass traIsEntryPoint ]) collect: [ :f | f ast traInstall ] ].
	testResult := TestResult new.
	exampleResults := {}.
	"needs identity, as method hash is not considering selector"
	callers := IdentityDictionary new.
	[ somePackages
		do: [ :e | 
			exampleResults := GtExplicitExampleGroup new
				examples: (e definedClasses flatCollect: #gtExamples);
				runAll.
			(e definedClasses select: [ :f | f isTestCase and: f isAbstract not ]) do: [ :f | f suite run: testResult ] ].
	asts do: [ :e | callers at: e method put: e traCallers ] ]
		ensure: [ asts do: #traUninstall ].
	^ exampleResults -> testResult -> callers
]
