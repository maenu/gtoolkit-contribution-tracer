Extension { #name : #RPackage }

{ #category : #'*Scoper-GToolkit' }
RPackage >> scoGtViewFor: aView [
	<gtView>
	^ [ (ScoResolver instance resolvePackage: self) value scoGtViewFor: aView ]
		on: ScoNoPackageFoundError
		do: [ aView explicit
				title: 'Call Graph (Scoper)' translated;
				priority: 50;
				stencil: [ BrLabel new
						text: 'no data';
						asElement ] ]
]
