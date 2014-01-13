path = require('path')
assert = require('assert')
should = require('should')
Content = require('../lib/content')
ContentLoader = require('../lib/content_loader')

describe 'ContentLoader', ->
  before (done) ->
    @base_dir = path.join(process.cwd(), 'test', 'fixtures', 'content')

    ContentLoader.all(@base_dir).then (content) =>
      @content = content
      @file_paths = (c.roots_cms_meta.path for c in content)
      done()

  describe '.all', ->
    it 'detects dynamic content files', ->
      @file_paths.should.include(path.join(@base_dir, 'post_1.md'))

    it 'ignores non-dynamic content files', ->
      @file_paths.should.not.include(path.join(@base_dir, 'not_dynamic_content.md'))

    it 'detects nested dynamic content files', ->
      @file_paths.should.include(path.join(@base_dir, 'nested_content', 'post_4.md'))

    it 'should not detect any files with yaml front matter that are in node module libraries', ->
      @file_paths.should.not.include(path.join(@base_dir, 'node_modules', 'some_lib', 'lib_content.md'))
