Class {
	#name : #TraResolver,
	#superclass : #Object,
	#instVars : [
		'packages'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Tracer-Core'
}

{ #category : #accessing }
TraResolver class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #adding }
TraResolver >> initialize [
	super initialize.
	packages := Dictionary new
]

{ #category : #accessing }
TraResolver >> packages [
	^ packages
]

{ #category : #accessing }
TraResolver >> packages: anObject [
	packages := anObject
]

{ #category : #'as yet unclassified' }
TraResolver >> resolveMethod: aMethod [
	^ ((self resolvePackage: aMethod package) value value associations
		detect: [ :e | e key methodClass = aMethod methodClass and: [ e key selector = aMethod selector ] ]
		ifNone: [ TraNoMethodFoundError new ]) value
]

{ #category : #'as yet unclassified' }
TraResolver >> resolvePackage: aPackage [
	^ packages at: aPackage ifAbsent: [ TraNoPackageFoundError new ]
]
