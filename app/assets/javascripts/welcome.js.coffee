$ ->
  $("form#sign_in_user, form#sign_up_user").bind("ajax:success", (event, xhr, settings) ->
    $(this).parents('.modal').modal('hide')
  ).bind("ajax:error", (event, xhr, settings, exceptions) ->
    $modal = $(this)
    if xhr.responseJSON['error']
      text = "<p class='text-danger'>" + xhr.responseJSON['error'] + "</p>"
      $(this).parents('.modal').find('.errors').html(text)
    else if xhr.responseJSON['errors']
      $.each(xhr.responseJSON["errors"], (k, v) ->
        $modal.find('.errors-' + k).html(v)
      )
    else
      text = "<p class='text-danger'>Unknown error</p>"
      $(this).parents('.modal').find('.errors').html(text)
  )