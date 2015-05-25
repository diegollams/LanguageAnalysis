@Words = React.createClass
  getInitialState: ->
    words: @props.data
  getDefaultProps: ->
    words: []
  addWord:(word) ->
    words = React.addons.update(@state.words, {$push: [word]})
    @setState words: words
  deleteWord: (word) ->
    index = @state.words.indexOf word
    words = React.addons.update(@state.words,  { $splice: [[index, 1]] })
    @replaceState words: words
  render: ->
    React.DOM.div
      className: 'words'
      React.DOM.h2
        className: 'title'
        'Words'
      React.createElement WordForm,handleNewWord: @addWord
      React.DOM.table
        className: 'table table-striped'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Word'
            React.DOM.th null, 'Type'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for word in @state.words
            React.createElement Word, key: word.id, word: word, handleDeleteWord: @deleteWord

