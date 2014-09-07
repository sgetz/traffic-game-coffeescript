###
Requires: Axis.coffee
###
class Spot
	constructor: (@x, @y) ->
		@id = "#{@x}, #{@y}"
	toJson: ->
		{@x, @y}
	toArray: ->
		[@x, @y]
	repr: ->
		"new Spot(#{@x}, #{@y})"
	moveForward: (axis) ->
		if axis = Axis.X
			@x += 1
		if axis = Axis.Y
			@y += 1
		@
	moveBackward: (axis) ->
		if axis = Axis.X
			@x -= 1
		if axis = Axis.Y
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
	@makeNew: (spot) ->
		if not (spot instanceof @)
			if _.isArray spot
					spot = @newFromArray spot
			else if _.isObject spot
					spot = @newFromJson spot
			else if _.isString spot
					spot = @newFromId spot
			else
				throw "Error in Spot.makeNew() couldnt make spot"
		return spot
