###
Requires Axis, Spot, _
###
class Auto
	constructor: (@color, spots...) ->
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
	###
	getTrunkSpot() -> Spot 
		returns the spot the trunk of the auto (the backside) is on
	###
	getTrunkSpot: ->
		movementAxisProp = if @axis == Axis.X then 'x' else 'y'
		_.min @spots, movementAxisProp
	###
	getHoodSpot() -> Spot
		returns the spot the hood of the auto (the front end) is on
	###
	getHoodSpot: ->
		movementAxisProp = if @axis == Axis.X then 'x' else 'y'
		_.max @spots, movementAxisProp
	###
	getForwardSpot() -> Spot
		returns the spot directly in front of the front (hood) of the auto
	###
	getForwardSpot: ->
		hoodSpot = @getHoodSpot()
		[changeX, changeY] = if @axis == Axis.X then [1, 0] else [0, 1]
		Spot.makeNew(hoodSpot.x + changeX, hoodSpot.y + changeY)
	###
	getBackwardSpot() -> Spot
		returns the spot directly in behind rear (trunk) of the auto
	###
	getBackwardSpot: ->
		trunkSpot = @getTrunkSpot()
		[changeX, changeY] = if @axis == Axis.X then [-1, 0] else [0, -1]
		Spot.makeNew(trunkSpot.x + changeX, trunkSpot.y + changeY)
	###
	moveForward() -> Auto
		returns a new instance of a Auto which has been advanced one spot
		forwards
	###
	moveForward: ->
		newSpots = (spot.copy().moveForward(@axis) for spot in @spots)
		new @constructor(@color, newSpots...)
	###
	moveBackward() -> Auto
		returns a new instance of a Auto which has moved backwards one spot
	###
	moveBackward: ->
		newSpots = (spot.copy().moveBackward(@axis) for spot in @spots)
		new @constructor(@color, newSpots...)
	getName: ->
		"#{@color}_#{@type}"
	getId: ->
		"""#{@getName()}@[#{("[#{spot.getId()}]" for spot in @spots).join(', ')}]"""
	repr: ->
		"""new Auto('#{@color}', #{("[#{spot.getId()}]" for spot in @spots).join(', ')})"""