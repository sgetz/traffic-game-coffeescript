buildConf = 
	bower_components: [
		'lodash/dist/lodash.min.js',
		'jshashes/hashes.min.js',
		'fabric/dist/fabric.min.js',
		'jquery/dist/jquery.min.js'
	]
	modules: [
		'app/game-objects/Axis.coffee'
		'app/game-objects/Spot.coffee'
		'app/game-objects/Auto.coffee',
		'app/game-objects/Truck.coffee',
		'app/game-objects/Car.coffee',
		'app/game-objects/Lot.coffee',
		'app/game-objects/test-1.coffee',
		'app/canvas-objects/global-canvas.coffee',
		'app/canvas-objects/draw-grid.coffee',
		'app/canvas-objects/draw-auto.coffee',
		'app/canvas-objects/test-2.coffee',
	]
	styles: []
	generateScriptTags: ->
		scriptTags = []
		for bower_component in @bower_components
			scriptTags.push """<script src="#{bower_component}"></script>"""
		for module in @modules
			module = module.replace /\.coffee/, '.js'

			scriptTags.push """<script src="#{module}"></script>"""
		scriptTags.join('\n')


module.exports = buildConf