module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig

    "gh-pages":
      options:
        base: 'build/website'
        branch: 'gh-pages'
        repo: 'https://github.com/Kikobeats/server-for-dummies.git'
      src: ['**/*']

    clean:
      files: '.grunt'

  grunt.registerTask 'publish', ['gh-pages', 'clean']