class User.UI
  constructor: (@api) ->
    @bio = ''
    @profession = ''
    @email = ''
    @name = ''
    @details = {}

  initialize: ->
    @updateUserDetails()
    @profile_image_change()


  profile_image_change: ->
    # Display the image to be uploaded.
    $('.upload-profile-image').attr("disabled", true);
    self  = @
    $('.file-input').off("change").on 'change', (e) ->
      if event.target.files[0].size <= 1000000
        displayImage = URL.createObjectURL(event.target.files[0])
        $('div.image-div').css({"background-image" : "url(" + "#{displayImage}" + ")", "background-size":"cover"})
        $('.upload-profile-image').attr("disabled", false);
      else
        self.flashErrorMessage("You cannot upload this file because its size exceeds the maximum limit of 1 MB")
        return



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

        @api.upDateUserDetails(@details, self.flashErrorMessage)
          .then((res) -> (
            if res.message != "Profile Image changed successfully"
              self.flashErrorMessage(res.message) 
            else
              self.flashSuccessMessage(res.message)
              $('.upload-profile-image').attr("disabled", true);
          ))
        
  flashErrorMessage: (message) ->
    toastr.error(message)

  flashSuccessMessage: (message) ->
    toastr.success(message)
  

