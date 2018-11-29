Extension { #name : #RGMethodDefinition }

{ #category : #'*Tracer-GToolkit' }
RGMethodDefinition >> traGtSourceFor: aView [
	<gtView>
	^ self compiledMethod traGtSourceFor: aView
]
