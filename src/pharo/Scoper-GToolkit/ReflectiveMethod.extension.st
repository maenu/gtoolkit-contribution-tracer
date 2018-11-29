Extension { #name : #ReflectiveMethod }

{ #category : #'*Scoper-GToolkit' }
ReflectiveMethod >> scoGtSourceFor: aView [
	<gtView>
	^ self compiledMethod scoGtSourceFor: aView
]
