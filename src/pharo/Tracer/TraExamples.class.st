Class {
	#name : #TraExamples,
	#superclass : #Object,
	#category : #'Tracer-Examples'
}

{ #category : #accessing }
TraExamples >> neoJsonCore [
	<gtExample>
	| methods collector testResult |
	methods := #'Neo-JSON-Core' asPackage methods.
	collector := TraCallerCollector new.
	testResult := TestResult new.
	collector
		collectAll: methods
		doing: [ (#'Neo-JSON-Tests' asPackage definedClasses select: [ :e | e isTestCase and: e isAbstract not ]) do: [ :e | e suite run: testResult ] ].
	^ testResult -> collector asCallers -> methods
]
