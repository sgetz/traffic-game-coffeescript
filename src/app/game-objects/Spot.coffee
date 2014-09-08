###
Requires: Axis.coffee, Lodash
###
class Spot
	constructor: (x, y) ->
		x = _.parseInt x if _.isString x
		y = _.parseInt y if _.isString y
		@x = x
		@y = y
	getId: ->
		"#{@x}, #{@y}"
	toJson: ->
		{@x, @y}
	toArray: ->
		[@x, @y]
	repr: ->
		"new Spot(#{@x}, #{@y})"
	copy: ->
		new @constructor(@x, @y)
	isEqual: (otherSpot) ->
		@getId() == otherSpot.getId()
	moveForward: (axis) ->
		if axis == Axis.X
			@x += 1
		if axis == Axis.Y
			@y += 1
		@
	moveBackward: (axis) ->
		if axis == Axis.X
			@x -= 1
		if axis == Axis.Y
			@y -= 1
		@
	###
		class method for contstrunting new Spots
	###
	@newFromId: (id) ->
		[x, y] = id.split(', ')
		new @(x, y)
	@newFromJson: ({x, y}) ->
		new @(x, y)
	@newFromArray: ([x, y]) ->
		new @(x, y)
	###
		Spot.makeNew classmethod for easy creation of spots
		ways to use:
			Spot.makeNew(x, y) -> Spot(x, y)
			Spot.makeNew([x, y]) -> Spot(x, y)
			Spot.makeNew('x, y') -> Spot(x, y)
			Spot.makeNew({x: x, y: y}) -> Spot(x, y)
	###
	@makeNew: (spot, y=null) ->
		if not (spot instanceof @)
			if y != null
				spot = new @(spot, y)
			else if _.isArray spot
					spot = @newFromArray spot
			else if _.isObject spot
					spot = @newFromJson spot
			else if _.isString spot
					spot = @newFromId spot
			else
				throw "Error in Spot.makeNew() couldnt make spot"
		return spot
