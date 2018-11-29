Class {
	#name : #ScoExamples,
	#superclass : #Object,
	#category : #'Scoper-Examples'
}

{ #category : #accessing }
ScoExamples >> deepTraverserExamples [
	<gtExample>
	| collector callers |
	collector := ScoCallerCollector new.
	callers := collector collectAll: #DeepTraverser asPackage methods doing: [ #'DeepTraverser-Examples' asPackage gtExamplesContained do: #run ].
	^ callers
]

{ #category : #accessing }
ScoExamples >> deepTraverserTests [
	<gtExample>
	| testResult collector callers |
	collector := ScoCallerCollector new.
	testResult := TestResult new.
	callers := collector
		collectAll: #DeepTraverser asPackage methods
		doing: [ (#'DeepTraverser-Tests' asPackage definedClasses select: [ :e | e isTestCase and: e isAbstract not ]) do: [ :e | e suite run: testResult ] ].
	^ testResult -> callers
]
