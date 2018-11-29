Class {
	#name : #ScoExamples,
	#superclass : #Object,
	#category : #'Scoper-Examples'
}

{ #category : #accessing }
ScoExamples >> deepTraverser [
	<gtExample>
	| package collector association |
	package := #DeepTraverser asPackage.
	collector := ScoCallerCollector new.
	association := collector collectIn: {package} , ({#'DeepTraverser-Examples' . #'DeepTraverser-Tests'} collect: #asPackage).
	ScoResolver instance packages at: package put: association.
	^ association
]
