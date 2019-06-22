class User.Micropost.UI
  constructor: (@api) ->
    @content = ''
    @micropost = {}
    @micropost_id = ''

  initialize: () ->
    @displayModal()
    @closeCreateModal()
    @createMicropost()
    @deleteMicropost()
    @closeDeleteModal()

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
    $('.delete-micropost .delete-micropost-text').on 'click', -> 
      self.micropost_id =  $(this).attr("data-id")
      $('.modal-field-delete').show()
      $('.micropost-btn-delete').on 'click', -> 
        self.api.deleteMicropost(self.micropost_id, self.flashErrorMessage)
          .then((res) -> (
            if res.message == 'Micropost deleted'
              self.flashSuccessMessage(res.message)
              $('.modal-field-delete').hide()
              location.reload()
            else
              self.flashErrorMessage(res.message)
          )
        )



  closeDeleteModal: ->
    $('span.micropost-delete-close').on 'click', ->
      $('.modal-field-delete').hide()

    $('.modal-field-delete').on 'click', (e)->
      if not e.target.closest('.micropost-modal-content')
        $('.modal-field-delete').hide()

  closeCreateModal: ->
    $('span.micropost-close').on 'click', ->
      $('.modal-field').hide()

    $('.modal-field').on 'click', (e)->
      if not e.target.closest('.micropost-modal-content')
        $('.modal-field').hide()

  flashErrorMessage: (message) ->
    toastr.error(message)

  flashSuccessMessage: (message) ->
    toastr.success(message)