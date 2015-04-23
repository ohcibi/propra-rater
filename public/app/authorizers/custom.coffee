`import Base from 'simple-auth/authorizers/base'`

isEmpty = Ember.isEmpty

CustomAuthorizer = Base.extend
  authorize: (jqXHR, requestOptions) ->
    token = @get "session.secure.token"
    if @get("session.isAuthenticated") and not isEmpty token
      jqXHR.setRequestHeader "X-PROPRA-KEY", token

`export default CustomAuthorizer`
