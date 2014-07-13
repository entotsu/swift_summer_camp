


# enableFtpWatch = false



# SASS_DIR = './sass'
# COFFEE_DIR = './coffee'

FTP_DEST = "/www/home/okamoto/summer_camp"

FTP_CONFIG =
    build:
        auth:
            host: "dsn4.sakura.ne.jp"
            port: 21
            authKey: "dsn"
        src: "."
        dest: FTP_DEST
        exclusions: [
            ".*"
            "./node_modules"
            "./node_modules/*"
            "**/Thumbs.db"
            "Gruntfile.*"
            '**/.DS_Store'
            '**/.DS_Store*'
            'grunt-contrib-*'
            'package.json'
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
                    dest: 'public/'
                    ext: '.html'
                ]

        # compass:
        #     dev:
        #         options:
        #             config: 'config.rb'
        #             environment: 'development'
        #             force: true
        #     prod:
        #         options:
        #             config: 'config.rb'
        #             environment: 'production'
        #             force: true
        compass:
            dist:
                options:
                    sassDir: "sass"
                    cssDir: "public/css/"
        coffee:
            compile:
                options:
                    bare: true
                files: [
                    expand: true
                    cwd: 'coffee'
                    src: ['**/*.coffee']
                    dest: 'public/js/'
                    ext: '.js'
                ]



        # connect:
        #   server:
        #     options:
        #         livereload: true
        connect:
            server:
                options:
                    port: 3000
                    hostname: "*"
                    base: 'public'
                    livereload: 35729





        esteWatch:
            options:
                dirs: [
                    "coffee/**"
                    "jade/**"
                    "sass/**"
                    "public/**"
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


            # sass: (file) ->
                # return if getTarget(file) is 'mobile' then ['compass:dev', 'cssmin:mobile'] else ['compass:dev', 'concat:css', 'cssmin:common']

        # esteWatch:
        #     options:
        #         dirs: ['.', SASS_DIR, COFFEE_DIR]
        #         livereload:
        #             enabled: true
        #             extensions: ['jade', 'styl', 'stylus','html','css','js']
        #             port: 35729
        #     jade: (filepath) ->
        #         grunt.config 'jade.options.pretty', true
        #         grunt.config 'jade.compile.files', [
        #             expand: true
        #             ext: '.html'
        #             src: filepath
        #         ]
        #         'jade'
        #     styl: '<%= esteWatch.stylus %>'
        #     stylus: (filepath) ->
        #         grunt.config 'stylus.options.compress', false
        #         grunt.config 'stylus.compile.files', [
        #             expand: true
        #             ext: '.css'
        #             src: filepath
        #         ]
        #         'stylus'
        #     coffee: (filepath) ->
        #         files = [
        #             expand: true
        #             ext: '.js'
        #             src: filepath
        #         ]
        #         grunt.config 'coffee.compile.files', files
        #         ['coffee:compile']
        #     sass: (filepath) ->
        #         files = [
        #             expand: true
        #             ext: '.css'
        #             src: filepath
        #         ]
        #         grunt.config 'sass.compile.files', files




    # if enableFtpWatch
    #     conf.esteWatch['*'] = (filepath) -> return ['ftpush']

    grunt.initConfig conf





    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-este-watch'
    # grunt.loadNpmTasks 'grunt-ftpush'
    grunt.loadNpmTasks 'grunt-ftp-deploy'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-newer'
    # grunt.loadNpmTasks 'grunt-bower-task'
    # grunt.loadNpmTasks 'grunt-contrib-stylus'
    # npm install grunt-contrib-connect grunt-contrib-jade grunt-contrib-stylus grunt-contrib-coffee grunt-este-watch grunt-ftpush grunt-ftp-deploy --save-dev



    grunt.registerTask 'make', ['newer:coffee', 'newer:jade', 'newer:compass']
    grunt.registerTask 'default', ['make', 'connect', 'esteWatch']

    # if enableFtpWatch
    #     grunt.registerTask 'default', ['connect', 'esteWatch', 'ftpush']#FTPあり
    # else
    #     grunt.registerTask 'default', ['connect', 'esteWatch']#FTPなし


    return