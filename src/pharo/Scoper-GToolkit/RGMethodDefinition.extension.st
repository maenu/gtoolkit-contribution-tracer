Extension { #name : #RGMethodDefinition }

{ #category : #'*Scoper-GToolkit' }
RGMethodDefinition >> scoGtSourceFor: aView [
	<gtView>
	^ self compiledMethod scoGtSourceFor: aView
]
