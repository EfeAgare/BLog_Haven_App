class Search.UI
  constructor: ->
   @search_data = ''
   @attribute = ''

  initialize: ->
   @handleSelectClick()
   @handleAttributeSelectOption()
   



  handleSelectClick: ->
    $(".search-box").on 'click', (event)  ->
      event.stopPropagation()
      $(".modifiers-list").show()
      

    # close dropdown if any part of the page is clicked
    $(document).click ->
      $(".modifiers-list").hide()
  

  handleAttributeSelectOption: ->
   self = @
   $(".by-attribute").off("click").click (e) ->
    self.attribute = $(this).text()
    self.attribute_value = self.attribute.split(" ")[1]
    $(".modifier").text(self.attribute_value)
    $(".modifiers-list").hide()
    e.stopPropagation()
    $(".search-input").off("click").click (e) ->
     $(".modifiers-list").hide()
     e.stopPropagation()
     self.handleSearchSubmit()
  
  handleSearchSubmit: () ->
   self = @
   $(".search-input").off("keypress").on 'keypress', (e) ->
    if (e.which == 13 )
      self.search_data = $.trim($(".search-input").val())
      e.stopPropagation()
      if !self.search_data 
        self.flashErrorMessage("Please type in a value to search")
        return
      else
        console.log self.search_data
        console.log self.attribute_value
        return 
    
  flashErrorMessage: (message) ->
    toastr.error(message)

  flashSuccessMessage: (message) ->
    toastr.success(message)