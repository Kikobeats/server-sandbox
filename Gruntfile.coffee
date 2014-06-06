module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    "gh-pages":
      options:
        base: 'build/website'
        branch: 'gh-pages'
        repo: 'https://github.com/Kikobeats/server-sandbox'
      src: ['**/*']

    clean:
      files: '.grunt'

  grunt.registerTask 'publish', ['gh-pages', 'clean']