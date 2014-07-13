Template.home.rendered = ->
  #SEO Page Title & Description
  document.title = "Sundrop .BIT Faucet"
  $("<meta>", { name: "description", content: document.title }).appendTo "head"

  $.getScript "http://www.google.com/recaptcha/api/js/recaptcha_ajax.js", ->
    Recaptcha.create "6Ldf7vQSAAAAAEboq3LTtRJriyJ9KOdNzB4IN9xm", "rendered-captcha-container",
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
      #add the data from form inputs here
    console.log "[home:21 - calling meteor]", formData
    Meteor.call 'payout', formData, (error, result) ->
      if (result.success)
        alert('Bitcoin sent to your address!\nEnjoy and thank you for using Sundrop.bit')
      else
        Recaptcha.reload()

        # alert error message according to received code
        switch result.error
          when 'captcha_verification_failed'
            alert('captcha solution is wrong!')
          when 'other_error_on_form_submit'
            alert('other error')
          else
            alert('error')
