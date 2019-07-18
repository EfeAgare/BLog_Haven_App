class Search.App
  constructor: ->
    @ui = new Search.UI()

  start: ->
    @ui.initialize()