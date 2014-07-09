path      = require 'path'
expect    = require('chai').expect
RootsCMS  = require '../lib'
Content   = require '../lib/content'

describe 'Content', ->
  before ->
    @cms = new RootsCMS(path.join(__dirname, 'fixtures', 'project_with_config'))

  describe '#parse', ->
    it 'should parse the content body correctly', ->
      content = new Content(@cms, 'blog_posts/api')
      content.parse()
      expect(content.get('content')).to.equal("Imagine a series of gridded laser lights projected ahead of you.\n\n17 years ago, that's how I would have introduced Carrot's new API.\n")
