



FTP_DEST = "/www/ver3/summer-camp14"

FTP_CONFIG =
    build:
        auth:
            host: "dsn3.sakura.ne.jp"
            port: 21
            authKey: "three"
        src: "."
        dest: FTP_DEST
        exclusions: [
            ".*"
            "./node_modules"
            "./node_modules/*"
            "**/Thumbs.db"
            # "Gruntfile.*"
            '**/.DS_Store'
            '**/.DS_Store*'
            'grunt-contrib-*'
            'package.json'
            # "././img"#写真
        ]
        keep: []
        simple: true
        useList: false







module.exports = (grunt) ->

    conf =

        pkg: grunt.file.readJSON('package.json')

        ftpush: FTP_CONFIG
        'ftp-deploy': FTP_CONFIG


        jade:
            compile:
                options:
                    pretty: true
                files: [
                    expand: true
                    cwd: 'jade'
                    src: ['*.jade']
                    dest: './'
                    ext: '.html'
                ]

        compass:
            dist:
                options:
                    sassDir: "sass"
                    cssDir: "./css/"
        coffee:
            compile:
                options:
                    bare: true
                files: [
                    expand: true
                    cwd: 'coffee'
                    src: ['**/*.coffee']
                    dest: './js/'
                    ext: '.js'
                ]


        connect:
            server:
                options:
                    port: 3000
                    hostname: "*"
                    base: '.'
                    livereload: 35729





        esteWatch:
            options:
                dirs: [
                    "coffee/**"
                    "jade/**"
                    "sass/**"
                    "*"
                ]
                livereload:
                    enabled: true
                    extensions: ['js', 'html', 'css']
                    port: 35729
            coffee: (path) ->
                ['newer:coffee']
            jade: (path) ->
                ['newer:jade']
            sass: (path) ->
                ['compass']

    grunt.initConfig conf



    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-este-watch'
    grunt.loadNpmTasks 'grunt-ftp-deploy'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-newer'



    grunt.registerTask 'make', ['newer:coffee', 'newer:jade', 'newer:compass']
    grunt.registerTask 'default', ['make', 'connect', 'esteWatch']


    return