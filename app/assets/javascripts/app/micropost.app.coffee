class User.Micropost.App
  constructor: ->
    @api = new User.API()
    @ui = new User.Micropost.UI(@api)

  start: () ->
    @ui.initialize()

