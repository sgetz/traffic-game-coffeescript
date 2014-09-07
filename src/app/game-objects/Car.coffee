class Car extends Auto
	constructor: (color, spots...) ->
		super color, spots...
		@type = 'car'
		if @size != 2
			throw "Error: size of truck wasnt 3!"
	repr: ->
		"""new Car('#{@color}', #{("[#{spot.id}]" for spot in @spots).join(', ')})"""