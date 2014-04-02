path      = require 'path'
expect    = require('chai').expect
Browser   = require 'zombie'
browser   = new Browser
RootsCMS  = require '../lib'
Server    = require '../lib/server'


describe 'Server', ->

  describe '#constructor()', ->

    it 'raises an error if no CMS object is passed in'

  describe '#start()', ->

    it 'starts the server'
    it 'throws an error if the server is already running'

  describe '#stop()', ->

    it 'stops the server'
    it 'throws an error if the server is already stopped'
