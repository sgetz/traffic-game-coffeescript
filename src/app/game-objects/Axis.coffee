class Axis
	@X: 'X'
	@Y: 'Y'

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
			return @X
		if allYSame
			return @Y
		return null