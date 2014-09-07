
class Lot
	constructor: (@xSize, @ySize, @exitSpot, autos...) ->
		@parentId = null
		@configuration = {}

		for auto in autos
			@configuration[auto.getName()] = auto
	repr: ->
		autosReper = []
		for own name, auto of @configuration
			autosReper.push auto.repr()
		autosReper = autosReper.sort()
		"""new Lot(#{@xSize}, #{@ySize}, #{@exitSpot.repr()}, #{autosReper.join(', ')})"""

	getId: ->
		MD5 = new Hashes.MD5()
		MD5.hex @repr

	setParentId: (parentId) ->
		@parentId = parentId

	getOpenSpots: ->
		"TODO"
	getOccupyedSpots: ->
		"TODO"
	moveAuto: (auto) ->
		"?TODO?"