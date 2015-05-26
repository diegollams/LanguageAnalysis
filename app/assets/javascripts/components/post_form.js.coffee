@PostForm = React.createClass
  getInitialState: ->
    title: ''
    body: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { post: @state }, (data) =>
      @props.handleNewPost data
      @setState @getInitialState()
#    implement funtion for evaluated the rate and descripbe the feeling in the post
    .done (data) ->
      alert data.rate
    , 'JSON'
  valid: ->
    @state.title && @state.body
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
        React.DOM.div
          className: 'form-group'
          React.DOM.input
            type: 'text'
            className: 'form-control'
            placeholder: 'Body'
            name: 'body'
            value: @state.body
            onChange: @handleChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create post'
