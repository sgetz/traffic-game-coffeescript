###
Requires: hashes.js, Spot
###
class Lot
	constructor: (@xSize, @ySize, @exitSpot, autos...) ->
		@parentId = null
		@configuration = {}
		@_isOpenMap = null # cache IsOccupiedMap
		@_openSpots = null # cache open spots
		@_occupyedSpots = null # cache occupyed spots

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

	###
	getIsOpenMap() -> {spotId: isOpenBool}
		returns a object mapping all posible spotId in the Lot to a bool
		indicating weather the spot is open
	###
	getIsOpenMap: ->
		return @_isOpenMap if @_isOpenMap
		isOpenMap = {}
		for xSpot in [0...@xSize]
			for ySpot in [0...@ySize]
				isOpenMap[Spot.makeNew([xSpot, ySpot]).getId()] = true
		for occupyedSpot in @getOccupyedSpots()
			isOpenMap[occupyedSpot.getId()] = false
		@_isOpenMap = isOpenMap
		@_isOpenMap

	###
	getOpenSpots() -> []Spot
		returns a array of all open spots in the lot
	###
	getOpenSpots: ->
		return @_openSpots if @_openSpots
		isOpenMap = @getIsOpenMap()
		@_openSpots = (Spot.makeNew(spotId) for own spotId, isOpen of isOpenMap when isOpen)
		@_openSpots

	###
	getOccupyedSpots() -> []Spot
		returns a array of all spots which have autos in them on the Lot
	###
	getOccupyedSpots: ->
		return @_occupyedSpots if @_occupyedSpots
		occupyedSpots = []
		for own autoName, auto of @configuration
			for spot in auto.spots
				occupyedSpots.push spot
		@_occupyedSpots = occupyedSpots
		@_occupyedSpots

	###
	canMoveAutoForward(Auto|autoNameStr) -> Bool
		returns bool indicating weather given auto can move a Spot forward
	###
	canMoveAutoForward: (autoId) ->
		if autoId instanceof Auto
			autoId = autoId.getName()
		if not (autoId of @configuration)
			throw 'Error in canMoveAutoForward: couldnt auto in lot'
		auto = @configuration[autoId]
		isOpenMap = @getIsOpenMap()
		forwardSpot = auto.getForwardSpot()
		isOpenMap[forwardSpot.getId()] or false

	###
	canMoveAutoBackward(Auto|autoNameStr) -> Bool
		returns bool indicating weather given auto can move a Spot backward
	###
	canMoveAutoBackward: (autoId) ->
		if autoId instanceof Auto
			autoId = autoId.getName()
		if not (autoId of @configuration)
			throw 'Error in canMoveAutoForward: couldnt auto in lot'
		auto = @configuration[autoId]
		isOpenMap = @getIsOpenMap()
		backwardSpot = auto.getBackwardSpot()
		isOpenMap[backwardSpot.getId()] or false

	###
	moveAutoForward(Auto|autoNameStr) -> Lot
		returns a new Lot instance with the given Auto moved forward
		Note: can pass a Auto instance or a autoNameStr
	###
	moveAutoForward: (autoId) ->
		if autoId instanceof Auto
			autoId = autoId.getName()
		newLotsAutos = []
		for own configAutoId, auto of @configuration
			if configAutoId == autoId
				auto = auto.moveForward() # move forward
			newLotsAutos.push auto
		new @constructor(@xSize, @ySize, @exitSpot, newLotsAutos...)

	###
	moveAutoForward(Auto|autoNameStr) -> Lot
		returns a new Lot instance with the given Auto moved forward
		Note: can pass a Auto instance or a autoNameStr
	###
	moveAutoBackward: (autoId) ->
		if autoId instanceof Auto
			autoId = autoId.getName()
		newLotsAutos = []
		for own configAutoId, auto of @configuration
			if configAutoId == autoId
				auto = auto.moveBackward() # move backward
			newLotsAutos.push auto
		new @constructor(@xSize, @ySize, @exitSpot, newLotsAutos...)


	###
	###
	computeAllPossibleMoves: ->
		#TODO: consider making this a generator
		possibleMoves = []
		for own autoId, auto of @configuration
			if @canMoveAutoForward(autoId)
				possibleMoves.push @moveAutoForward(autoId)
			if @canMoveAutoBackward(autoId)
				possibleMoves.push @moveAutoBackward(autoId)
		possibleMoves

