module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    config:
      buildFile: 'sdk/widgets.js'
      source: [
        'src/main.coffee'
        'src/console.coffee'
        'src/event.coffee'
        'src/widget.coffee'
        'src/modal.coffee'
        'src/dispatch.coffee'
        'src/bootstrap.coffee'
      ]
      libraries: [
        'lib/es5-shim/es5-shim.js'
        'lib/jquery/dist/jquery.js'
      ]

    coffee:
      build:
        options:
          join: true
        files:
          '<%= config.buildFile %>': '<%= config.source %>'
      test:
        expand: true
        cwd: 'test'
        src: ['**/*.coffee']
        dest: 'build'
        ext: '.js'

    concat:
      build:
        src: [
          '<%= config.libraries %>'
          '<%= config.buildFile %>'
        ]
        dest: '<%= config.buildFile %>'

    uglify:
      options:
        report: 'gzip'
        banner: """/**
        * CrowdTwist Widgets SDK for JavaScript
        * v<%= pkg.version %>
        * <%= grunt.template.today("yyyy-mm-dd") %>
        **/
        """
      build:
        files:
          '<%= config.buildFile %>': ['<%= config.buildFile %>']

    express:
      test:
        options:
          script: 'server.js'

    protractor_webdriver:
      test:
        options:
          path: 'node_modules/.bin/'
          command: 'webdriver-manager start'

    protractor:
      test:
        options:
          configFile: 'config/e2e.conf.js'
          keepAlive: true
          noColor: false

    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: ['test/unit/helper.js']
        src: ['build/unit/**/*.js']

    clean:
      build:
        src: ['<%= config.buildFile %>']
      test:
        src: ['build/']


  grunt.registerTask 'build', [
    'clean:build'
    'coffee:build'
    'concat:build'
    'uglify:build'
  ]

  grunt.registerTask 'e2e', [
    'protractor_webdriver:test'
    'protractor:test'
  ]

  grunt.registerTask 'unit', [
    'mochaTest:test'
  ]

  grunt.registerTask 'test', [
    'build'
    'clean:test'
    'coffee:test'
    'express:test'
    'unit'
    'e2e'
    'clean:test'
  ]
