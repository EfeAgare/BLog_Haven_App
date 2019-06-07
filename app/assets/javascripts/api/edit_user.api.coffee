class User.API
  createPitch: (data, afterError) ->
   return $.ajax(
      url: "/users/update"
      type: "PATCH"
      data: data
      error: (error) ->
        afterError(error.statusText)
    )