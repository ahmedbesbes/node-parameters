[![Build Status](https://secure.travis-ci.org/adaltas/node-parameters.png)](http://travis-ci.org/adaltas/node-parameters)

# `npm install parameters`

Node parameters is sugar for parsing typical unix command line options. 

*   Standard and commands-based command lines (think `git pull ...`)
*   Asymetric: parse and stringify
*   Complete tests and samples

## Standard command line example

```javascript
command = parameters({
  name: 'server',
  description: 'Start a web server',
  options: [{
    name: 'host', shortcut: 'h', 
    description: 'Web server listen host'
  },{
    name: 'port', shortcut: 'p', type: 'integer', 
    description: 'Web server listen port'
  }]
});
// Print help
console.log( command.help() );
// Extract command arguments
command.parse(
  ['node', 'server.js', '--host', '127.0.0.1', '-p', '80']
).should.eql({
  host: '127.0.0.1',
  port: 80
});
// Create a command
command.stringify({
  host: '127.0.0.1',
  port: 80
}).should.eql(
  ['--host', '127.0.0.1', '--port', '80']
);
```

## Command-based command line example

```javascript
command = parameters({
  name: 'server',
  description: 'Manage a web server',
  commands: [{
    name: 'start',
    description: 'Start a web server',
    options: [{
      name: 'host', shortcut: 'h', 
      description: 'Web server listen host'
    },{
      name: 'port', shortcut: 'p', type: 'integer', 
      description: 'Web server listen port'
    }]
  }]
});
// Print help
console.log( command.help() );
// Extract command arguments
command.parse(
  ['node', 'server.js', 'start', '--host', '127.0.0.1', '-p', '80']
).should.eql({
  command: 'start',
  host: '127.0.0.1',
  port: 80
});
// Create a command
command.stringify({
  command: 'start',
  host: '127.0.0.1',
  port: 80
}).should.eql(
  ['start', '--host', '127.0.0.1', '--port', '80']
);
```

Help usage
----------

Here's an example on how to integrate the help functionnality.

```javascript
params = parameters(my_config).parse())
if( params.command === 'help' ){
  return console.log(parameters.help(params.command));
}
```

This will satisfy a help command with or without an extra command such as
`myscript help` and `myscript help mycommand`.

Development
-----------

Tests are executed with mocha. To install it, simple run `npm install`, it will
install mocha and its dependencies in your project "node_modules" directory.

To run the tests:
```bash
npm test
```

The tests run against the CoffeeScript source files.

To generate the JavaScript files:
```bash
make build
```

The test suite is run online with [Travis][travis] against Node.js version 0.6, 0.7, 0.8 and 0.9.

Contributors
------------

*   David Worms: <https://github.com/wdavidw>
