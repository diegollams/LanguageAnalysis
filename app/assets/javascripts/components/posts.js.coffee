@Posts = React.createClass
  getInitialState: ->
    posts: @props.data
  getDefaultProps: ->
    posts: []
  addPost: (post) ->
    posts = @state.posts.slice()
    posts.push post
    @setState posts: posts
  render: ->
    React.DOM.div
      className: 'posts'
      React.DOM.h2
        className: 'title'
        'Posts'
      React.createElement PostForm, handleNewPost: @addPost
      React.DOM.hr null
      React.DOM.table
        className: 'table table-striped'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Body'
            React.DOM.th null, 'value'
            React.DOM.th null, 'evaluated'
        React.DOM.tbody null
          for post in @state.posts
            React.createElement Post, key: post.id, post: post
