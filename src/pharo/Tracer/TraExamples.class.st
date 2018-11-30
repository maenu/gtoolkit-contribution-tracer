Class {
	#name : #TraExamples,
	#superclass : #Object,
	#category : #'Tracer-Examples'
}

{ #category : #accessing }
TraExamples >> deepTraverser [
	<gtExample>
	| package collector association |
	package := #DeepTraverser asPackage.
	collector := TraCollector new.
	association := collector collectIn: {package} , ({#'DeepTraverser-Examples' . #'DeepTraverser-Tests'} collect: #asPackage).
	TraResolver instance packages at: package put: association.
	^ association
]
