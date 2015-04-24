`import Ember from 'ember'`

get = Ember.get

isEmpty = Ember.isEmpty

ICONS = error: "times-circle", warning: "exclamation-triangle"

run = Ember.run

makeErrors = (errors) ->
  if errors.ident?
    errors.ident =
      state: "error"
      message: errors.ident

  if errors.password?
    errors.password =
      state: "error"
      message: errors.password

  errors

LoginController = Ember.Controller.extend
  actions:
    authenticate: ->
      @reset()
      creds = @getProperties "ident", "password"
      unless isEmpty(get creds, "ident") or isEmpty get creds, "password"
        @get "session"
          .authenticate "authenticator:custom", creds
          .then => @reset()
          .catch (error) =>
            run => @setProperties
              errorMessage: error.message
              errors: makeErrors error.errors
      else
        @setProperties
          errorMessage: "Passwort oder Benutzernamen eingeben!"
          errors:
            ident: state: "warning"
            password: state: "warning"

  reset: -> @setProperties errorMessage: null, errors: null

  validationState: (->
    state = "warning"

    if "error" in [@get("errors.ident.state"), @get("errors.password.state")]
      state = "danger"

    state
  ).property "errors.ident.state", "errors.password.state"

  identValidationState: (->
    "has-feedback has-#{@get "errors.ident.state"}" if  @get("errors.ident")?
  ).property "errors.ident"

  identValidationIcon: (->
    ICONS[@get "errors.ident.state"]
  ).property "errors.ident.state"

  passwordValidationState: (->
    if @get("errors.password")?
      "has-feedback has-#{@get "errors.password.state"}"
  ).property "errors.password"

  passwordValidationIcon: (->
    ICONS[@get "errors.password.state"]
  ).property "errors.password.state"

`export default LoginController`
