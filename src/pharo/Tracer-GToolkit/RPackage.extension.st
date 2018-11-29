Extension { #name : #RPackage }

{ #category : #'*Tracer-GToolkit' }
RPackage >> traGtViewFor: aView [
	<gtView>
	^ [ (TraResolver instance resolvePackage: self) value traGtViewFor: aView ]
		on: TraNoPackageFoundError
		do: [ aView explicit
				title: 'Call Graph (Scoper)' translated;
				priority: 50;
				stencil: [ BrLabel new
						text: 'no data';
						asElement ] ]
]
