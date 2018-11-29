Extension { #name : #CompiledMethod }

{ #category : #'*Tracer-GToolkit' }
CompiledMethod >> traGtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source (Scoper)' translated;
		priority: 1;
		actionStencil: [ BrButton new
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons browse asElement;
				action: [ self browse ] ];
		stencil: [ | coder |
			coder := TraGtMethodCoder forMethod: self.
			coder expanded: true.
			coder asElement ]
]
