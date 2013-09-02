###
This is a Gruntfile in coffeescript format it does these steps
1) Compile and minify all client side iced-coffee-script in "client/js".
2) Watch and redo (1) if any changes in "client/js".
3) Restart entire server if any "/server" files change.
###

module.exports = (grunt)->
    #Config grunt
    grunt.initConfig

        #Read package.json
        pkg: grunt.file.readJSON('package.json')

        #Watch for changes
        watch: 
            dev:
                files: ['client/js/*.coffee','server/*.coffee']
                tasks: ['wipejs','coffee']

        #Convert client/js/*.coffee to client/js/*.js
        coffee:
            default: 
                options:
                    bare: true
                expand: true,
                flatten: true,
                cwd: 'client/js/'
                src: ['*.coffee']
                dest: 'client/js'
                ext: '.js'
        
        #Convert client/js/*.js to client/js/*.min.js
        uglify:
            default:
                files: 
                    'client/js/client.min.js': ['client/js/*.js']
                options: 
                    mangle: false

        #Monitor server side for changes and restart
        nodemon: 
            dev: 
                options:
                    watchedFolders: ['server']
                    exec: 'iced'

        #Run nodemon and watch at the same time
        concurrent: 
            nodemon_watch: 
                tasks: ['nodemon','watch']
                options: 
                    logConcurrentOutput: true

        #Run nodemon and watch at the same time
        shell: 
            iced_app: 
                options: {stdout: true}
                command: 'iced app.coffee'
            heroku_add: 
                options: {stdout: true}
                command: 'git add .'
            heroku_commit: 
                options: {stdout: true}
                command: 'git commit -m "committed using grunt"'
            heroku_push: 
                options: {stdout: true}
                command: 'git push heroku master'

    #Load grunt modules
    grunt.loadNpmTasks 'grunt-iced-coffee'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-concurrent'
    grunt.loadNpmTasks 'grunt-nodemon'
    grunt.loadNpmTasks 'grunt-shell'
    
    #Delete only the minified JS file
    grunt.registerTask 'cleanmin', ->
        files = grunt.file.expand ['client/js/client.min.js']
        for file in files
            console.log 'File '+file+' deleted.'
            grunt.file.delete file        

    #Delete all JS files except the minified one
    grunt.registerTask 'cleanjs', ->
        files = grunt.file.expand ['client/js/*.js','!client/js/*.min.js']
        for file in files
            console.log 'File '+file+' deleted.'
            grunt.file.delete file

    #Delete all JS files
    grunt.registerTask 'wipejs', ->
        files = grunt.file.expand ['client/js/*.js']
        for file in files
            console.log 'File '+file+' deleted.'
            grunt.file.delete file

    #Task to run server and watch all changes to server and client folders
    grunt.registerTask 'dev', ->
        grunt.task.run 'wipejs'
        grunt.task.run 'coffee'
        grunt.task.run 'concurrent:nodemon_watch'

    #Production just compile then run server
    grunt.registerTask 'prod', ->
        grunt.task.run 'cleanmin'
        grunt.task.run 'coffee'
        grunt.task.run 'uglify'
        grunt.task.run 'cleanjs'
        grunt.task.run 'shell:iced_app'
    
    #Production just compile then run server
    grunt.registerTask 'heroku', ->
        grunt.task.run 'cleanmin'
        grunt.task.run 'coffee'
        grunt.task.run 'uglify'
        grunt.task.run 'cleanjs'
        grunt.task.run 'shell:heroku_add'
        grunt.task.run 'shell:heroku_commit'
        grunt.task.run 'shell:heroku_push'


