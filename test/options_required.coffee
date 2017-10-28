
should = require 'should'
parameters = require '../src'

describe 'options required', ->

  it 'honors required true if value is provided', ->
    params = parameters commands: [
      name: 'mycommand'
      options: 
        name: 'my_argument'
        required: true
    ]
    params.parse(['mycommand', '--my_argument', 'my --value']).should.eql
      command: 'mycommand'
      my_argument: 'my --value'
    params.stringify
      command: 'mycommand'
      my_argument: 'my --value'
    .should.eql ['mycommand', '--my_argument', 'my --value']

  it 'honors required true if no value provided', ->
    params = parameters commands: [
      name: 'mycommand'
      options: 
        name: 'my_argument'
        required: true
    ]
    (->
      params.parse ['mycommand']
    ).should.throw 'Required option argument "my_argument"'
    (->
      params.stringify
        command: 'mycommand'
    ).should.throw 'Required option argument "my_argument"'
