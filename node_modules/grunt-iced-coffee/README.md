## Compile IcedCoffeeScript files to JavaScript
Direct 'drop-in' replacement for 'grunt-contrib-coffee' albeit using [IcedCoffee](http://maxtaco.github.io/coffee-script/) 'defer' and 'await' keywords. Greatly reduce complexity of writing asynchronous ops in coffeescript.  

## Getting Started
This plugin requires Grunt `~0.4.0`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-iced-coffee --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-iced-coffee');
```

*This plugin was designed to work with Grunt 0.4.x. If you're still using grunt v0.3.x it's strongly recommended that [you upgrade](http://gruntjs.com/upgrading-from-0.3-to-0.4), but in case you can't please use [v0.3.2](https://github.com/gruntjs/grunt-contrib-coffee/tree/grunt-0.3-stable).*


## Coffee task
_Run this task with the `grunt coffee` command._

Task targets, files and options may be specified according to the grunt [Configuring tasks](http://gruntjs.com/configuring-tasks) guide.
### Options

#### separator
Type: `String`
Default: linefeed

Concatenated files will be joined on this string.

#### bare
Type: `boolean`

Compile the JavaScript without the top-level function safety wrapper.

#### join
Type: `boolean`
Default: `false`

When compiling multiple .coffee files into a single .js file, concatenate first.

#### sourceMap
Type: `boolean`
Default: `false`

Compile JavaScript and create a .map file linking it to the CoffeeScript source. When compiling multiple .coffee files to a single .js file, concatenation occurs as though the 'join' option is enabled. The concatenated CoffeeScript is written into the output directory, and becomes the target for source mapping.
### Usage Examples

```js
coffee: {
  compile: {
    files: {
      'path/to/result.js': 'path/to/source.coffee', // 1:1 compile
      'path/to/another.js': ['path/to/sources/*.coffee', 'path/to/more/*.coffee'] // compile and concat into single file
    }
  },

  compileBare: {
    options: {
      bare: true
    },
    files: {
      'path/to/result.js': 'path/to/source.coffee', // 1:1 compile
      'path/to/another.js': ['path/to/sources/*.coffee', 'path/to/more/*.coffee'] // compile and concat into single file
    }
  },

  compileJoined: {
    options: {
      join: true
    },
    files: {
      'path/to/result.js': 'path/to/source.coffee', // 1:1 compile, identical output to join = false
      'path/to/another.js': ['path/to/sources/*.coffee', 'path/to/more/*.coffee'] // concat then compile into single file
    }
  },

  compileWithMaps: {
    options: {
      sourceMap: true
    },
    files: {
      'path/to/result.js': 'path/to/source.coffee', // 1:1 compile
      'path/to/another.js': ['path/to/sources/*.coffee', 'path/to/more/*.coffee'] // concat then compile into single file
    }
  },

  glob_to_multiple: {
    expand: true,
    flatten: true,
    cwd: 'path/to',
    src: ['*.coffee'],
    dest: 'path/to/dest/',
    ext: '.js'
  }
}
```
