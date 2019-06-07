class User.UI
  constructor: (@api) ->
    @bio = ''
    @profession = ''
    @email = ''
    @name = ''
    @details = {}

  initialize: ->
    @updateUserDetails()

  updateUserDetails: ->
    self = @
    $('.submit-update').on 'click', () =>
      @name =  $("#user-name").val()
      @bio = $("#user-bio").val()
      @profession = $("#user-professsion").val()
      @email = $("#user-email").val()

      if (!@name )
         self.flashErrorMessage("Input your name")
      else if (!@profession )
         self.flashErrorMessage("Input your profession")
      else if (!@email)
         self.flashErrorMessage("input an email")
      else if (!@bio)
         self.flashErrorMessage("input your bio")
      else
        @details = {
          name: @name,
          bio: @bio,
          profession: @profession;
          email: @email
        }

        @api.createPitch(@details, self.flashErrorMessage)
          .then((res) -> (
             self.flashSuccessMessage(res.message)
          ))
        
  flashErrorMessage: (message) ->
    toastr.error(message)

  flashSuccessMessage: (message) ->
    toastr.success(message)
  

