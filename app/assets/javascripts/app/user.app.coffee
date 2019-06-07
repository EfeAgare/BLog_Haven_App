class User.App
  constructor: ->
    @api = new User.API()
    @ui = new User.UI(@api)

  start: ->
    @ui.initialize()

