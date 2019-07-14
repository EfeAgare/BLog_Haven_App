class User.Article.UI
  constructor:  ->
   @result = ''

  initialize: ->
   @article_image()
  #  @article_body_and_title_validation()
   @time_to_read()


  article_image: ->
    $('div.article-image').hide()
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



  # article_body_and_title_validation: ->
  #   self = @
  #   $(".fake-submit").off("click").click (e) ->
  #     self.articleBody = $("#article_content").val()
  #     self.article_title = $(".article_title").val()
  #     if self.article_title.replace(/\s/g, '').length < 5 
  #       self.flashErrorMessage("*Article Title must be at least 5 characters long")
  #       return
  #     else if self.articleBody.replace(/\s/g, '').length < 5 
  #       self.flashErrorMessage("*Article body must be at least 20 characters long")
  #     else
  #       $(".real-submit").show()
  #       $(".fake-submit").hide()
      
  flashErrorMessage: (message) ->
    toastr.error(message)

  flashSuccessMessage: (message) ->
    toastr.success(message)
  