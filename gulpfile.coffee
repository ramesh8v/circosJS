gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
gutil = require 'gulp-util'
less = require 'gulp-less'
path = require 'path'
mocha = require 'gulp-mocha'
watch = require 'gulp-watch'

gulp.task 'concat', ->
    gulp.src [
        'src/circos.coffee'
        'src/dataParser.coffee'
        'src/layout.coffee'
        'src/tracks.coffee'
        'src/tracks/*.coffee'
        'src/rendering/*.coffee'
        'src/render.coffee'
        'src/defaultParameters.coffee'
    ]
    .pipe concat 'circosJS.coffee'
    .pipe gulp.dest 'build'
    .on 'error', gutil.log

gulp.task 'compile', ['concat'], ->
    gulp.src 'build/circosJS.coffee'
    .pipe coffee bare: true
    .pipe gulp.dest 'dist'

gulp.task 'build', ['compile']

gulp.task 'watch', ['build'], ->
    gulp.watch 'src/**/*.coffee', ['compile']

gulp.task 'test', ['concat'], ->
    gulp.src 'test/*.coffee', read: false
    .pipe mocha reporter: 'nyan', compilers: 'coffee:coffee-script'
    .on 'error', gutil.log
