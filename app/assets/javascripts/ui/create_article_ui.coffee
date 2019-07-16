class User.Article.UI
  constructor:  ->
   @result = ''

  initialize: ->
   @article_image()
  #  @article_body_and_title_validation()
   @time_to_read()


  article_image: ->
    self  = @
    $('.file-input-article').off("change").on 'change', (e) ->
      if event.target.files[0].size <= 1000000 
        displayImage = URL.createObjectURL(event.target.files[0])

        $('div.article-image img').attr({"src" : "#{displayImage}"})
        $('div.article-image').show()
        $('img.image-display').show()
        $('.fa-times').css('display', 'unset')
      else
        self.flashErrorMessage("You cannot upload this file because its size exceeds the maximum limit of 1 MB")
        return
      

    $('.fa-times').off("click").click ->
      self.image_delete()
  
  
  image_delete: ->
    $('img.image-display').removeAttr('src')
    $('div.article-image').hide()
    $('img.image-display').hide()
    $('.fa-times').hide()


  time_to_read: ->
    self = @
    self.wordsPerMinute = 200; 
    self.textLength = $(".article-body").text()
    self.textLength = self.textLength.split(" ").length;
    if self.textLength > 0
      self.value = Math.ceil(self.textLength / self.wordsPerMinute);
      self.result = "#{self.value} min read";
    
    $(".time-to-read").text("#{self.result}")

      
  flashErrorMessage: (message) ->
    toastr.error(message)

  flashSuccessMessage: (message) ->
    toastr.success(message)
  