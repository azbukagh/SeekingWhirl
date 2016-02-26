var gulp = require('gulp'),
	jade = require('gulp-jade'),
	sass = require('gulp-sass'), 
	csso = require('gulp-csso'),
	uglify = require('gulp-uglify'),
	webserver = require('gulp-webserver'),
	rigger = require('gulp-rigger');

gulp.task('sass', function () {
	gulp.src('./dev/sass/main.scss')
		.pipe(sass().on('error', sass.logError))
		.pipe(gulp.dest('./public/css'));
});

gulp.task('jade', function() {
	gulp.src(['./dev/template/**/*.jade', '!./dev/template/**/_*.jade'])
		.pipe(jade({
			pretty: true
		}))
		.on('error', console.log)
	.pipe(gulp.dest('./'));
}); 

gulp.task('js', function() {
	gulp.src('./dev/js/**/*.js')
		.pipe(rigger())
		.pipe(gulp.dest('./public/js'));
});

gulp.task('images', function() {
	gulp.src('./dev/img/**/*')
		.pipe(gulp.dest('./public/img'));
	
});

gulp.task('fonts', function() {
	gulp.src('./dev/fonts/**/*')
		.pipe(gulp.dest('./public/fonts'));
});

gulp.task('http-server', function() {
	gulp.src('./')
		.pipe(webserver({
			host: "localhost",
			port: 9000,
			fallback: 'index.html',
			livereload: false
			
		}));
});

gulp.task('watch', function() {
	gulp.start('sass');
	gulp.start('jade');
	gulp.start('images');
	gulp.start('js');
	gulp.start('fonts');
	
	gulp.watch('dev/sass/**/*.scss', function() {
		gulp.start('sass');
	});
	gulp.watch('dev/template/**/*.jade', function() {
		gulp.start('jade');
	});
	gulp.watch('dev/img/**/*', function() {
		gulp.start('images');
	});
	gulp.watch('dev/js/**/*', function() {
		gulp.start('js');
	});
	gulp.start('http-server');
});

gulp.task('build', function() {
	gulp.src('./dev/sass/main.scss')
		.pipe(sass().on('error', sass.logError))
		.pipe(csso())
		.pipe(gulp.dest('./public/css'));
	gulp.src(['./dev/template/*.jade', '!./dev/template/_*.jade'])
		.pipe(jade())
		.pipe(gulp.dest('./'));
	gulp.src('./dev/js/**/*.js')
		.pipe(rigger())
		.pipe(uglify())
		.pipe(gulp.dest('./public/js'));
	gulp.src('./dev/img/**/*')
		.pipe(gulp.dest('./public/img'));
	gulp.src('./dev/fonts/**/*')
		.pipe(gulp.dest('./public/fonts'));
});
