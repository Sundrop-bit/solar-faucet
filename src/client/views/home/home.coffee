Template.home.rendered = ->
  IP_ADDRESS = "72.131.33.128"
  RECAPTCHA_PUBLIC_KEY = "6Le4nvkSAAAAAMZZPSplk1vxvWeGaclt-Pz-QkxP"

  #SEO Page Title & Description
  document.title = "Sundrop .BIT Faucet"
  $("<meta>", { name: "description", content: document.title }).appendTo "head"

  if location.hostname isnt IP_ADDRESS
    location.href = IP_ADDRESS
    return

  $.getScript "http://www.google.com/recaptcha/api/js/recaptcha_ajax.js", ->
    Recaptcha.create RECAPTCHA_PUBLIC_KEY, "rendered-captcha-container",
      theme: "red"
      callback: Recaptcha.focus_response_field


Template.home.events
  'submit form#captcha': (event) ->
    event.preventDefault()
    event.stopPropagation()

    formData =
      captcha_challenge_id: Recaptcha.get_challenge(),
      captcha_solution: Recaptcha.get_response()
      destination: $('#destination').val()
    Meteor.call 'payout', formData, (error, result) ->
      if (result.success)
        alert('Bitcoin sent to your address!\nEnjoy and thank you for using Sundrop.bit')
      else
        Recaptcha.reload()

        # alert error message according to received code
        switch result.error
          when 'captcha_verification_failed'
            alert('Captcha solution is wrong, please try again.')
          when 'other_error_on_form_submit'
            alert('Sorry, there has been an error processing this. Please contact support@sundrop.bit')
          else
            alert('Sorry, there has been an error processing this. Please contact support@sundrop.bit')
