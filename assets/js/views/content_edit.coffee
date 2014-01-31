define ['marionette', 'templates', 'underscore', 'marked', 'pen', 'html_md', 'dropzone', 'pen_markdown'], (Marionette, templates, _, marked, Pen, md, Dropzone) ->
  class ContentEdit extends Marionette.ItemView
    template: templates.content_edit

    ui:
      'content': '.contents'
      'data': '.data input'
      'back': '.back'
      'upload': '.upload'
      'upload_area': '.upload-area'

    events:
      'click button': 'save'
      'click .back': 'go_back'
      'click .upload': 'upload_image'

    templateHelpers: ->
      content_to_html: (-> marked(@model.get('content'))).bind(@)
      category: (-> @category_display()).bind(@)

    onRender: ->
      new Pen
        editor: @ui.content[0]
        list: [
          'blockquote', 'h2', 'h3', 'p', 'insertorderedlist', 'insertunorderedlist',
          'indent', 'outdent', 'bold', 'italic', 'underline', 'createlink', 'image'
        ]

    get_data: ->
      _.reduce @ui.data, (data, el) ->
        data[$(el).attr('name')] = $(el).val()
        return data
      , {}

    category_display: ->
      cats = @model.get('id').split('/')
      cats.pop()
      cats.join('/')

    upload_image: ->
      @ui.upload_area.show()
      drop = new Dropzone(@ui.upload_area[0], { url: '/api/upload_image', })
      drop.on 'success', (file, res) =>
        @ui.upload_area.replaceWith("<img src=\"#{res.url}\"/>")

    save: ->
      modified_content = md(@ui.content.html())
      @model.set('content', modified_content)
      @model.set('data', @get_data())
      @model.save()
      @render()
