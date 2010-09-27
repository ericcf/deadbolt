# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if defined? Deadbolt::Application
  Deadbolt::Application.config.secret_token = '14fc438c8398c67523304ed00f4ab8b51b31c4b81e1d2ad41036762481e54ed34476c4b63b3dd2ed98d388cbf2e3ed16460b39c17132cee826fa89a8ae146e83'
end
