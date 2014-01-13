fs = require('fs')
path = require('path')
require('coffee-script')
assert = require('assert')
js_yaml = require('js-yaml')
Content = require('../lib/content')

describe 'Content', ->
  before ->
    @path = path.join(process.cwd(), 'test', 'fixtures', 'content', 'post_1.md')
    @file = fs.readFileSync(@path, 'utf8')
    @content = new Content(@path)

  it 'should load its file from the path passed in', ->
    assert.equal(@content.path, @path)

  it 'should parse the yaml front matter', ->
    assert.equal(@content.get('order'), 1)
    assert.equal(@content.get('title'), 'Post 1')

  it 'should parse the content outside of the front matter', ->
    assert.equal(@content.get('content'), 'Some content underneath the front matter.\n')

  describe '#get', ->
    it 'should retrieve the attribute from the data object', ->
      assert.equal(@content.get('order'), 1)
      assert.equal(@content.get('title'), 'Post 1')

  describe '#set', ->
    it 'should set the attribute into the data object', ->
      @content.set('order', 2)
      assert.equal(@content.get('order'), 2)

  describe '#save', ->
    before ->
      @content.set('order', 3)
      @content.set('title', 'Rewrote the file')
      @content.set('body', 'Some info')
      @content.save()

    it 'should save the data object back into the content file', ->
      contents = fs.readFileSync(@path, 'utf8')
      @content.parse()
      assert.equal(@content.get('order'), 3)
      assert.equal(@content.get('title'), 'Rewrote the file')

    it "shouldn't override any other content in the file", ->
      contents = fs.readFileSync(@path, 'utf8')
      assert.equal(true, (contents.indexOf('Some content underneath the front matter') != -1))

    after ->
      fs.writeFileSync(@path, @file)
