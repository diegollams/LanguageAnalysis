@Modal = React.createClass
  render: ->
    React.DOM.div
      id: 'modal'
      className: 'modal fade'
      ariaHidden: 'true'
      ariaLabellebdy: 'myModalLabel'
      'asdasdas'
      React.DOM.div
        className: 'modal-dialog'
        React.DOM.div
          className: 'modal-content'
          React.DOM.div
            className: 'modal-header'
            'El evaluador concluyo'
          React.DOM.div
            className: 'modal-body'
            @props.message

#
#    #myModal.{"aria-hidden" => "true", "aria-labelledby" => "myModalLabel", :role => "dialog", :tabindex => "-1"}
#      .modal-dialog
#        .modal-content
#          .modal-header
#          %button.close{"aria-label" => "Close", "data-dismiss" => "modal", :type => "button"}
#          %span{"aria-hidden" => "true"} ×
#          %h4#myModalLabel.modal-title Modal title
#        .modal-body
#          asda
#        .modal-footer
#          %button.btn.btn-default{"data-dismiss" => "modal", :type => "button"} Close
#          %button.btn.btn-primary{:type => "button"} Save changes