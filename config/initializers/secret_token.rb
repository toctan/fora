# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

Fora::Application.config.secret_key_base =
  if Rails.env.production?
    ENV['SECRET_TOKEN']
  else
    '305026b3e3f1aa6ee03d9d930a05f815bc7fd30859eca3ee4d82cf36255fb08e9dc8fe267c'
  end
