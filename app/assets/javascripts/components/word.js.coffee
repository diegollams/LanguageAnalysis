@Word = React.createClass
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "words/#{@props.word.id}"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteWord @props.word

  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.word.content
      React.DOM.td null, booleanToType(@props.word.kind)
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'