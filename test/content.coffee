fs        = require 'fs'
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

  describe '#save', ->
    before ->
      @path = path.join(__dirname, 'fixtures', 'project_with_config', 'blog_posts', 'api.jade')
      @fixture = fs.readFileSync(@path)

    it 'should save the content body with the correct jade layout formatting', ->
      content = new Content(@cms, 'blog_posts/api')
      content.set('content', "Some other content.\n\nTesting.")
      content.save()

      reloaded_content = new Content(@cms, 'blog_posts/api')
      expect(content.contents.indexOf('extends ../_single\nblock content\n  :markdown\n    Some other content.\n    \n    Testing.'))
        .to.be.above(-1)

    after ->
      fs.writeFileSync(@path, @fixture)
