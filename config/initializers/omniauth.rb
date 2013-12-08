Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
  provider :weibo,   ENV['WEIBO_KEY'],    ENV['WEIBO_SECRET']
end
