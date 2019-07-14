class User.API
  upDateUserDetails: (data, afterError) ->
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
      url: "/user/microposts/#{id}"
      type: "DELETE"
      headers: {
            'X-CSRF-Token': Rails.csrfToken()
      },
      dataType: 'json'
      error: (error) ->
        afterError(error.statusText)
    )

  upLoadUserProfile: (data, afterError) ->
    return $.ajax(
        url: "/user/upload"
        type: "PATCH"
        data: data
        headers: {
            'X-CSRF-Token': Rails.csrfToken()
        },
        dataType: 'json'
        error: (error) ->
          afterError(error.statusText)
      )

  