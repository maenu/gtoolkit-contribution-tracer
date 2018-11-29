Extension { #name : #ReflectiveMethod }

{ #category : #'*Tracer-GToolkit' }
ReflectiveMethod >> traGtSourceFor: aView [
	<gtView>
	^ self compiledMethod traGtSourceFor: aView
]
