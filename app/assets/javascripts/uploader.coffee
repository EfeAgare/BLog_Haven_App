image_post = ->
# Display the image to be uploaded.
  $('.file-input').on 'change', (e) ->
    displayImage = URL.createObjectURL(event.target.files[0])
    $('.image-div').show()
    $('.fa-times').css('display', 'unset')
    $('.image-display').attr('src', displayImage)


image_delete = ->
    $('.image-display').removeAttr('src')
    $('.image-div').hide()
    $('.fa-times').hide()


$(document).ready(
  image_post
  $(document).on 'click', '.fa-times', image_delete
)