`import Ember from 'ember'`

TopNavComponent = Ember.Component.extend
  actions:
    logout: -> @sendAction "logout"

  tagName: "nav"

  classNames: [
    "navbar"
    "navbar-default"
    "navbar-fixed-top"
  ]

  initCollapse: (->
    @$().collapse()
  ).on "didInsertElement"

`export default TopNavComponent`
