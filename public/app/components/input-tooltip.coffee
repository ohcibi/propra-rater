`import Ember from 'ember'`

computed = Ember.computed

InputTooltipComponent = Ember.Component.extend
  classNames: "tooltip"

  classNameBindings: ["position", "tooltipVisible"]

  click: -> @set "open", false

  messageNotEmpty: computed.notEmpty "message"

  open: true

  reOpenOnMessageChange: (-> @set "open", true).observes "message"

  tooltipVisible: computed.and "open", "messageNotEmpty"

`export default InputTooltipComponent`
