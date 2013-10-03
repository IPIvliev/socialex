OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '507563635999574', 'fa7c2f707fd4ba8ca60694631b70625d'
end