Class {
	#name : #ScoResolver,
	#superclass : #Object,
	#instVars : [
		'packages'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Scoper-Core'
}

{ #category : #accessing }
ScoResolver class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #adding }
ScoResolver >> initialize [
	super initialize.
	packages := Dictionary new
]

{ #category : #accessing }
ScoResolver >> packages [
	^ packages
]

{ #category : #accessing }
ScoResolver >> packages: anObject [
	packages := anObject
]

{ #category : #'as yet unclassified' }
ScoResolver >> resolveMethod: aMethod [
	^ ((self resolvePackage: aMethod package) value associations
		detect: [ :e | e key methodClass = aMethod methodClass and: [ e key selector = aMethod selector ] ]
		ifNone: [ ScoNoMethodFoundError new ]) value
]

{ #category : #'as yet unclassified' }
ScoResolver >> resolvePackage: aPackage [
	^ packages at: aPackage ifAbsent: [ ScoNoPackageFoundError new ]
]
