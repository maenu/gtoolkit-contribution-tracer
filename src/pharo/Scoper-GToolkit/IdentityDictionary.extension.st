Extension { #name : #IdentityDictionary }

{ #category : #'*Scoper-GToolkit' }
IdentityDictionary >> scoGtViewAsCallGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Call Graph';
		priority: 50;
		painting: [ :view | 
			| nodes |
			nodes := (self keys , ((self values flatCollect: #values) flatCollect: #yourself)) asIdentitySet.
			view nodes
				shape: [ :x | 
					BlElement new
						background:
							(x scoIsEntryPoint
								ifTrue: [ BlBackground paint: Color blue ]
								ifFalse: [ BlBackground paint: Color gray ]);
						geometry: BlEllipse new;
						size: 20 @ 20 ];
				with: nodes.
			view edges
				shape: [ :x | BlLineElement new border: (BlBorder paint: (Color red alpha: 0.5) width: 2) ];
				connectFromAll: [ :x | self at: x ifPresent: [ :e | e at: #direct ] ifAbsent: [ {} ] ].
			"view edges
				shape: [ :x | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 2) ];
				passive;
				connectFromAll: [ :x | self at: x ifPresent: [ :e | e at: #indirect ] ifAbsent: [ {} ] ]."
			view layout tree separateSubtrees: true ]
]
