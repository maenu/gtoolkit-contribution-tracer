Class {
	#name : #TraExamples,
	#superclass : #Object,
	#category : #'Tracer-Examples'
}

{ #category : #accessing }
TraExamples >> deepTraverser [
	<gtExample>
	| testResult collector callers |
	collector := TraCallerCollector new.
	testResult := TestResult new.
	callers := collector
		collectAll: #DeepTraverser asPackage methods
		doing: [ #'DeepTraverser-Examples' asPackage gtExamplesContained do: #run.
			(#'DeepTraverser-Tests' asPackage definedClasses select: [ :e | e isTestCase and: e isAbstract not ]) do: [ :e | e suite run: testResult ] ].
	^ testResult -> callers
]
