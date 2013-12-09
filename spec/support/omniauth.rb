OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => '1',
    'info' => {
      nickname: 'nick',
      image: nil
    }
  })
