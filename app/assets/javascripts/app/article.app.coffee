class User.Article.App
  constructor: ->
    @ui = new User.Article.UI()

  start: () ->
    @ui.initialize()

