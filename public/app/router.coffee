`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route "login"

  @resource "teams", path: "/", ->
    @resource "team", path: "/:namespace.path/:path", ->
      @resource "member", path: "/:username", ->
        @resource "rating", path: "/:milestone"

  @resource "statistics", path: "/statistiken"

`export default Router`
