module.exports = (grunt) ->
	require('load-grunt-tasks')(grunt)
	require('coffee-script/register')
	scriptTags = {scriptTags: require('./build').generateScriptTags()}
	
	######
	pkg = grunt.file.readJSON 'package.json'
	
	######
	coffee = 
		options:
			bare: true
			sourceMap: true

		src:
			expand: true
			cwd: 'src'
			src: '**/*.coffee'
			dest: 'compile'
			ext: '.js'

	######
	copy = 
		html:
			expand: true
			cwd: 'src'
			src: '**/*.html'
			dest: 'compile'
			options:
				processContent: (content, srcpath) -> 
					grunt.template.process(content)

	######
	clean =
		compile:
			src: ['compile']
	######
	connect = 
		server:
			options:
				port: 8000
				base: ['compile', 'bower_components', './']
				livereload: true

	######
	watch = 
		coffee_src: 
			files: ['src/**/*.coffee']
			tasks: ['coffee']
		html_src:
			options:
				livereload: true
			files: ['src/**/*.html']
			tasks: ['copy:html']
		compile:
			options:
				livereload: true
			files: ['compile/**/*']
			tasks: []

	
	gruntConfig = {pkg, connect, copy, clean, coffee, watch, scriptTags}
	grunt.initConfig gruntConfig

	

	grunt.registerTask 'default', ['clean', 'copy', 'coffee', 'connect:server', 'watch' ]