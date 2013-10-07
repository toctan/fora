OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    provider: 'twitter',
    uid: '123545',
    info: {
      nickname: 'nick',
      image: 'http://lorempixel.com/400/200/'
    }
  })
