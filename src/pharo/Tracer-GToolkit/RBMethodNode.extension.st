Extension { #name : #RBMethodNode }

{ #category : #'*Tracer-GToolkit' }
RBMethodNode >> traGtElement [
	^ [ [ (TraResolver instance resolveMethod: self method) traGtWholeForTest: Color purple lighter forExample: Color orange lighter ]
		on: TraNoPackageFoundError
		do: [ BlElement new ] ]
		on: TraNoMethodFoundError
		do: [ BlElement new ]
]
