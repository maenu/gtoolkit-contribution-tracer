Extension { #name : #CompiledMethod }

{ #category : #'*Scoper-GToolkit' }
CompiledMethod >> scoGtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source (Scoper)' translated;
		priority: 1;
		actionStencil: [ BrButton new
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons browse asElement;
				action: [ self browse ] ];
		stencil: [ | coder |
			coder := ScoGtMethodCoder forMethod: self.
			coder expanded: true.
			coder asElement ]
]
