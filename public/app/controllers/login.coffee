`import Ember from 'ember'`

get = Ember.get

isEmpty = Ember.isEmpty

LoginController = Ember.Controller.extend
  actions:
    authenticate: ->
      creds = @getProperties "ident", "password"
      unless isEmpty(get creds, "ident") or isEmpty get creds, "password"
        @get("session").authenticate "authenticator:custom", creds
      else
        alert "Passwort oder Benutername eingeben!"

`export default LoginController`
