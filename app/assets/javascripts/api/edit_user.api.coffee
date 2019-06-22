class User.API
  createPitch: (data, afterError) ->
   return $.ajax(
      url: "/users/update"
      type: "PATCH"
      headers: {
        'X-CSRF-Token': Rails.csrfToken()
      },
      data: data
      error: (error) ->
        afterError(error.statusText)
    )
  
  createMicropost: (data, afterError) ->
    return $.ajax(
       url: "/user/microposts"
       type: "POST"
       data: data
       headers: {
            'X-CSRF-Token': Rails.csrfToken()
       },
       dataType: 'json'
       error: (error) ->
         afterError(error.statusText)
     )

  deleteMicropost: (id, afterError) ->
    return $.ajax(
      url: "/user/microposts"
      type: "DELETE"
      data: id
      headers: {
            'X-CSRF-Token': Rails.csrfToken()
      },
      dataType: 'json'
      error: (error) ->
        afterError(error.statusText)
    )

  