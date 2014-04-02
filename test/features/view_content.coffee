path      = require 'path'
expect    = require('chai').expect
Browser   = require 'zombie'
browser   = new Browser
RootsCMS  = require '../../lib'

describe 'viewing categories and content', ->
  before (done) ->
    @port = 2222
    @url  = "http://localhost:#{@port}/"

    project = path.join(__dirname, '..', 'fixtures', 'test_project')
    @cms    = new RootsCMS(project, {env: 'test'})
    @cms.start().then(-> done()).catch((e) -> done(e))
    @category_name = 'blog_posts'

  describe 'viewing categories', (done) ->

    it 'root url displays the dynamic content directories', (done) ->
      browser.visit(@url).then ->
        expect(browser.text('li a')).to.contain 'blog_posts'
        done()
      .catch (e) -> done(e)

    it 'clicking on a category at root displays all content in a category', ->
      browser.visit(@url)
        .then -> browser.clickLink(@category_name)
        .then ->
          expect(browser.text('li')).to.contain 'doge'
          done()
        .catch (e) -> done(e)

    it 'visiting a category through a url displays all content in a category', ->
      browser.visit("#{@url}category/#{@category_name}")
        .then ->
          expect(browser.text('li')).to.contain 'doge'
          done()
        .catch (e) -> done(e)

  describe 'viewing content', (done) ->
    before ->
      @content_name     = 'doge'
      @front_matter     = 'Such Content'
      @markdown_content = 'Wow. Much content. Such static.'

    it 'clicking on a content on a category show page displays the content\'s front matter', ->
      browser.visit("#{@url}category/#{@category_name}")
        .then -> browser.clickLink('doge')
        .then ->
          expect(browser.query('input')).to.contain @front_matter
          done()
        .catch (e) -> done(e)

    it 'visiting content through a url displays the content\'s front matter', ->
      browser.visit("#{@url}category/#{@category_name}/#{@content_name}")
        .then ->
          expect(browser.query('input')).to.contain @front_matter
          done()
        .catch (e) -> done(e)

    it 'clicking on a content on a category show page displays the content\'s markdown content', ->
      browser.visit("#{@url}category/#{@category_name}")
        .then -> browser.clickLink('doge')
        .then ->
          expect(browser.query('input')).to.contain @markdown_content
          done()
        .catch (e) -> done(e)

    it 'visiting content through a url displays the content\'s front matter', ->
      browser.visit("#{@url}category/#{@category_name}/#{@content_name}")
        .then ->
          expect(browser.query('input')).to.contain @markdown_content
          done()
        .catch (e) -> done(e)

  after (done) ->
    @cms.stop().then(-> done()).catch((e) -> done(e))
