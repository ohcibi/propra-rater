`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @resource "teams", path: "/", ->
    @resource "team", path: "/:namespace.path/:path", ->
      @resource "member", path: "/:username"

`export default Router`
