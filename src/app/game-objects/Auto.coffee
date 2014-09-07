###
Requires Axis, Spot, _
###
class Auto
	constructor: (@color, spots...) ->
		console.log spots
		@size = spots.length
		@type = 'auto'
		@spots = (Spot.makeNew spot for spot in spots)
		@axis = Axis.determineAxis (spot.toArray() for spot in @spots)

	toJson: ->
		{@color, @size, @type, @spots, @axis}
	moveForward: ->
		for spot in @spots
			spot.moveForward @axis
		@
	moveBackward: ->
		for spot in @spots
			spot.moveBackward @axis
		@
	copy: ->
		new @constructor @color, (spot.toArray() for spot in @spots)...

	getName: ->
		"#{@color}_#{@type}"
	getId: ->
		"""#{@getName()}@[#{("[#{spot.id}]" for spot in @spots).join(', ')}]"""
	repr: ->
		"""new Auto(#{@color}, #{("[#{spot.id}]" for spot in @spots).join(', ')})"""