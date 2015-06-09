@Posts = React.createClass
  getInitialState: ->
    message: ''
    posts: @props.data
    lastPost: null
  getDefaultProps: ->
    posts: []
  addPost: (post) ->
    posts = React.addons.update(@state.posts, { $push: [post] })
    @setState message: post.message
    @setState posts: posts
    $('#modal').modal('show')
  deletePost: (post)->
    index = @state.posts.indexOf post
    posts = React.addons.update(@state.posts, { $splice: [[index, 1]] })
    @replaceState posts: posts
  editPost: (post,data) ->
    index = @state.posts.indexOf post
    posts = React.addons.update(@state.posts, { $splice: [[index, 1, data]] })
    @replaceState posts: posts
#  helpers
  rates: ->
    rates = @state.posts
    rates.reduce ((prev,current)->
      prev + current.rate
    ),0
  evaluateds: ->
    evaluated = @state.posts
    evaluated.reduce ((prev,current)->
      prev + current.evaluated
    ),0
  render: ->

    React.DOM.div
      className: 'posts'
      React.createElement Modal, message: @state.message
      React.DOM.h2
        className: 'title'
        'Posts'
      React.DOM.div
        className: 'row'
        React.createElement ValueBox, type: 'success', amount: @rates()/ @state.posts.length  ,text: 'Promedio General'
        React.createElement ValueBox, type: 'info', amount: @evaluateds() / @state.posts.length,text: 'Palabras evaluadas'
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
            React.DOM.th null, 'Words found'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for post in @state.posts
            React.createElement Post, key: post.id, post: post, handleDeletePost: @deletePost, handleEditPost: @editPost
