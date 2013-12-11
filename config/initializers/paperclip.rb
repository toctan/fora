if Rails.env.production?
  Paperclip::Attachment.default_options[:path] = '/:class/:style/:id.:extension'
  Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_credentials] = {
    bucket: ENV['S3_BUCKET_NAME'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_KEY']
  }
else
  Paperclip::Attachment.default_options[:url] = '/system/:class/:style/:id.:extension'
end
