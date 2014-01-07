fs = require('fs')
path = require('path')
require('coffee-script')
assert = require('assert')
js_yaml = require('js-yaml')
Content = require('../lib/content')

root_dir = process.cwd()

describe 'Content', ->
  before ->
    @path = path.join(root_dir, 'test/fixtures/content/post_1.md')
    @content = new Content(@path)

  it 'should load its file from the path passed in', ->
    assert.equal(@content.path, @path)

  it 'should parse the yaml front matter', ->
    assert.equal(@content.get('order'), 1)
    assert.equal(@content.get('title'), 'Post 1')

  describe '#get', ->
    it 'should retrieve the attribute from the data object', ->
      assert.equal(@content.get('order'), 1)
      assert.equal(@content.get('title'), 'Post 1')

  describe '#set', ->
    it 'should set the attibute into the data object', ->
      @content.set('order', 2)
      assert.equal(@content.get('order'), 2)

  describe '#save', ->
    it 'should save the data object back into the content file', ->
      @content.set('order', 3)
      @content.set('title', 'Rewrote the file')
      @content.save()

      contents = fs.readFileSync(@path, 'utf8')
      @content._parse()
      assert.equal(@content.get('order'), 3)
      assert.equal(@content.get('title'), 'Rewrote the file')
