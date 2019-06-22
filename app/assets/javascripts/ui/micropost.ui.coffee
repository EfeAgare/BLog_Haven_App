class User.Micropost.UI
  constructor: (@api) ->
    @content = ''
    @micropost = {}
    @micropost_id = ''

  initialize: () ->
    @displayModal()
    @closeModal()
    @createMicropost()
    @deleteMicropost()

  displayModal: () =>
    $('.micropost-create').on 'click', =>
      $('.modal-field').show()
      

  createMicropost: ->
    self = @
    $('.micropost-btn').on 'click', () =>
      @content = $('.micropost-body').val()
      @micropost = {
        content: @content
      }
      @api.createMicropost(@micropost, self.flashErrorMessage)
        .then((res) -> (
          if res.message == 'Micropost created successfully'
            self.flashSuccessMessage(res.message)
            $('.modal-field').hide()
            location.reload()
          else
            self.flashErrorMessage(res.message)
          ))

  deleteMicropost: -> 
    self = @
    $('.delete-micropost').on 'click', => 
      console.log $(this).attr("value")
      # console.log self.micropost_id
      # $('.modal-field-delete').show()



  closeModal: ->
    $('span.micropost-close').on 'click', ->
      $('.modal-field').hide()

    $('.modal-field').on 'click', (e)->
      if not e.target.closest('.micropost-modal-content')
        $('.modal-field').hide()

  flashErrorMessage: (message) ->
    toastr.error(message)

  flashSuccessMessage: (message) ->
    toastr.success(message)