FAUCET_AMOUNT_IN_SATOSHI = 1

BLOCKCHAIN_GUID = ""
BLOCKCHAIN_PASSWORD = ""
BLOCKCHAIN_PASSWORD2 = ""
BLOCKCHAIN_FEE_IN_SATOSHI = 0

RECAPTCHA_PRIVATE_KEY = ""

is_captcha_valid = (clientIP, data) ->
  captcha_data = #for recaptcha
    privatekey: RECAPTCHA_PRIVATE_KEY
    remoteip: clientIP
    challenge: data.captcha_challenge_id
    response: data.captcha_solution

  serialized_captcha_data = "privatekey=" + captcha_data.privatekey + "&remoteip=" + captcha_data.remoteip + "&challenge=" + captcha_data.challenge + "&response=" + captcha_data.response
  captchaVerificationResult = null
  success = undefined # used to process response string
  parts = undefined
  try
    captchaVerificationResult = HTTP.call("POST", "https://www.google.com/recaptcha/api/verify",
      content: serialized_captcha_data.toString("utf8")
      headers:
        "Content-Type": "application/x-www-form-urlencoded"
        "Content-Length": serialized_captcha_data.length
    )
  catch e
    return (
      success: false
      error: "google_service_not_accessible"
    )
  parts = captchaVerificationResult.content.split("\n")
  success = parts[0]
  if success is "true"
    return success: true
  else
    return (
      success: false
      error: "captcha_verification_failed"
    )

Meteor.methods payout: (data) ->
  verifyCaptchaResponse = is_captcha_valid(@connection.clientAddress, data)
  if true # verifyCaptchaResponse.success
    BlockchainWallet = Meteor.require("blockchain-wallet")
    wallet = new BlockchainWallet(BLOCKCHAIN_GUID, BLOCKCHAIN_PASSWORD, BLOCKCHAIN_PASSWORD2)
    wallet.payment data.destination, FAUCET_AMOUNT_IN_SATOSHI, {note: "Thanks for using Sundrop.bit!", fee: BLOCKCHAIN_FEE_IN_SATOSHI}
    , (err, bc_data) ->
      if err
        console.log "[methods:47 - err ]", err
        console.log "[methods:52 - data ]", bc_data
        return (
          success: false
          error: "Sorry, there was an error while sending funds. Please try back later!"
        )
      else
        return success: true
  else
    console.log "Captcha check failed! Responding with: ", verifyCaptchaResponse
  return verifyCaptchaResponse
