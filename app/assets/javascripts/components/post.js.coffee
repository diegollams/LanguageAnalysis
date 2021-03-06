@Post = React.createClass
  getInitialState: ->
    edit: false
  getDefaultProps: ->
    posts: []
  mixins: [ReactEmoji]

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "posts/#{@props.post.id}"
      dataType: 'JSON'
      success: () =>
        @props.handleDeletePost @props.post
  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: React.findDOMNode(@refs.title).value
      body: React.findDOMNode(@refs.body).value
    $.ajax
      method: 'PUT'
      url: "/posts/#{ @props.post.id }"
      dataType: 'JSON'
      data:
        post: data
      success: (data) =>
        @setState edit: false
        @props.handleEditPost @props.post, data
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  postRow: ->
    React.DOM.tr null,
      React.DOM.td null, ReactEmoji.emojify(@props.post.title)
      React.DOM.td null, ReactEmoji.emojify(@props.post.body)
      React.DOM.td null, @props.post.sum
      React.DOM.td null, @props.post.evaluated
      React.DOM.td null, @props.post.message
      React.DOM.td null,
        React.DOM.ul null,
          for word in @props.post.words
            React.DOM.li null, "#{word.content}(#{word.kind})"
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  postForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.post.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.post.body
          ref: 'body'
      React.DOM.td null, @props.post.sum
      React.DOM.td null, @props.post.evaluated
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-warning'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @postForm()
    else
      @postRow()
