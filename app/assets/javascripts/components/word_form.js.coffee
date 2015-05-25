@WordForm = React.createClass
  getInitialState: ->
    content: ''
    kind: ''
  valid: ->
    @state.content && @state.kind

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { word: @state }, (data) =>
      @props.handleNewWord data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Word'
          name: 'content'
          value: @state.content
          onChange: @handleChange
        React.DOM.select
          className: 'form-control'
          name: 'kind'
          value: @state.kind
          onChange: @handleChange
          React.DOM.option
            value: 'true'
            'Happy'
          React.DOM.option
            value: 'false'
            'Sad'
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create word'

