`import Base from 'simple-auth/authenticators/base'`
`import Ember from 'ember'`

get = Ember.get

Promise = Ember.RSVP.Promise

run = Ember.run

CustomAuthenticator = Base.extend
  token: null

  restore: (data) ->
    new Promise (resolve, reject) ->
      unless isEmpty get data, "token"
        resolve data
      else
        reject()

  authenticate: (data) ->
    new Promise (resolve, reject) =>
      Ember.$.ajax(
        url: "/sessions"
        type: "POST"
        contentType: "application/json"
        data: JSON.stringify
          session:
            ident: get data, "ident"
            password: get data, "password"
      ).then ((response) =>
        run =>
          @set "token", response.session.token
          resolve token: response.session.token
      ), (xhr, status, error) ->
        run -> reject JSON.parse xhr.responseText

  invalidate: ->
    new Promise (resolve, reject) =>
      Ember.$.ajax(
        url: "/sessions"
        type: "DELETE"
        data: JSON.stringify
          session: token: @get "token"
      ).always resolve()

`export default CustomAuthenticator`
