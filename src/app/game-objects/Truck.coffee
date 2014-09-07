class Truck extends Auto
	constructor: (color, spots...) ->
		super color, spots...
		@type = 'truck'
		if @size != 3
			throw "Error: size of truck wasnt 3!"
	repr: ->
		"""new Truck(#{@color}, #{("[#{spot.id}]" for spot in @spots).join(', ')})"""