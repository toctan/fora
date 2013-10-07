OmniAuth.config.test_mode = true

[:twitter, :weibo].each do |provider|
  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      provider: provider.to_s,
      uid: '123545',
      info: {
        nickname: 'nick',
        image: 'http://lorempixel.com/400/200/'
      }
    })
end
