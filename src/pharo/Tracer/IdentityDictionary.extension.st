Extension { #name : #IdentityDictionary }

{ #category : #'*Tracer' }
IdentityDictionary >> traGtViewAsCallGraphFor: aView [
	<gtView>
	^ aView explicit
		title: 'Call Graph';
		priority: 50;
		stencil: [ | nodes edges container |
			nodes := IdentityDictionary new.
			(self keys , (self values flatCollect: #yourself)) asIdentitySet
				do: [ :e | 
					nodes
						at: e
						put:
							(BlElement new
								size: 300 @ 300;
								background:
									(e isTestMethod
										ifTrue: [ Color blue ]
										ifFalse: [ e isGTExampleMethod
												ifTrue: [ Color green ]
												ifFalse: [ Color black ] ]);
								layout: BlFrameLayout new;
								addEventHandler: BlPullHandler new;
								in: [ :f | 
									f graph
										beNode;
										model: e ];
								addChild:
									(BrLabel new
										text: e asString;
										look: BrGlamorousLabelLook;
										constraintsDo: [ :c | 
											c frame horizontal alignCenter.
											c frame vertical alignCenter ]);
								yourself) ].
			edges := self associations
				flatCollect: [ :e | 
					| from |
					from := nodes at: e key.
					e value
						collect: [ :f | 
							| to edge element |
							to := nodes at: f.
							edge := GtGraphEdge new
								from: from to: to;
								yourself.
							from constraints graph addConnectedEdge: edge.
							to constraints graph addConnectedEdge: edge.
							element := BlLineElement new
								fromAnchor: (BlElementTopCenterAnchor element: to);
								toAnchor: (BlElementBottomCenterAnchor element: from);
								border: (BlBorder paint: Color gray width: 2);
								yourself.
							element graph beEdge.
							element ] ].
			nodes := nodes values.
			container := BlElement new
				clipChildren: false;
				layout: GtGradHorizontalTreeLayout new;
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
				addChildren: nodes;
				addChildren: edges;
				yourself.
			(container padding: (BlInsets all: 50)) asScalableElement ]
]
