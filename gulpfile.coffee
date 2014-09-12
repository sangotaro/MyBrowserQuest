gulp = require 'gulp'
plumber = require 'gulp-plumber'
concat = require 'gulp-concat'
mainBowerFiles = require 'main-bower-files'
source = require 'vinyl-source-stream'
coffee = require 'gulp-coffee'
browserify = require 'browserify'
rsync = require 'gulp-rsync'
runSequence = require 'run-sequence'
watch = require 'gulp-watch'
sequence = require 'gulp-watch-sequence'

gulp.task 'coffee', ->
  gulp.src './server/src/**/*.coffee'
    .pipe plumber()
    .pipe coffee bare: true
    .pipe gulp.dest './server/build'

gulp.task 'coffeeify', ->
  browserify
    entries: ['./client/src/main.coffee']
    extensions: ['.coffee']
  .transform 'coffeeify'
  .bundle()
  .pipe plumber()
  .pipe source 'build.js'
  .pipe gulp.dest './client/build'

gulp.task 'vendor', ->
  gulp.src mainBowerFiles()
    .pipe plumber()
    .pipe concat 'vendor.js'
    .pipe gulp.dest './client/build'

gulp.task 'deploy', ->
  gulp.src './client/build/**/*.js'
    .pipe rsync
      root: './client/build'
      destination: './public'

gulp.task 'watch', ['build'], ->
  queue = sequence 1000
  watch './server/src/**/*.coffee', ['coffee']
  watch './client/src/**/*.coffee', queue.getHandler 'coffeeify', 'deploy'
  watch './bower_components/**/*.js', queue.getHandler 'vendor', 'deploy'

gulp.task 'build', ['coffee', 'coffeeify', 'vendor']
gulp.task 'default', (callback) ->
  runSequence 'build', 'deploy', callback
