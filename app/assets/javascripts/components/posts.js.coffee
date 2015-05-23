@Posts = React.createClass
  getInitialState: ->
    records: @props.data
  getDefaultProps: ->
    records: []
  render: ->
    React.DOM.div
      className: 'posts'
      React.DOM.h2
        className: 'title'
        'Posts'