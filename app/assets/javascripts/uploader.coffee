image_post = ->
# Display the image to be uploaded.
  $('div').removeClass('image-div img')
  $('.file-input').on 'change', (e) ->
    displayImage = URL.createObjectURL(event.target.files[0])
    $('div').addClass('image-div img')
    $('.fa-times').css('display', 'unset')
    $('.image-display').attr('src', displayImage)


image_delete = ->
      # Display the image to be uploaded.
    $('.image-display').attr('src', '')
    $('div').removeClass('image-div img')
    $('.fa-times').hide()


$(document).ready(
  image_post
  $(document).on 'click', '.fa-times', image_delete
)