###
Axis

	The Axis indicates axis along which the Auto can move

###
class Axis
	@X: 'X'
	@Y: 'Y'

	###
	Axis.determineAxis([[1, 3], [1, 4], [1, 5]]) -> Axis.Y

	determineAxis returns the axis along which a auto can move
		it determins this by looking at which cordinate is
		constance among the set of cords passed in. The
		axis of movement will be the one that isnt constant
	###
	@determineAxis: ([firstCord, restCords...]) ->
		allXSame = true
		allYSame = true
		for cord in restCords
			if cord[0] != firstCord[0]
				allXSame = false
			if cord[1] != firstCord[1]
				allYSame = false
		if allXSame and allYSame
			throw "Error in Axis.determineAxis() all posstions are same"
		if allXSame
			return @Y
		if allYSame
			return @X
		return null