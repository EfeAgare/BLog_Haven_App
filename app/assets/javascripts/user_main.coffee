$(document).on "turbolinks:load", ->
    ui = new User.App()
    ui.start()
    # ui = new Search.App()
    # ui.start()