Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1187829091254806", "33c993c6ce557656d32b76c7ca53fa9e", scope: 'email', info_fields: 'email,name'
  #:scope => 'email',
   #:info_fields => 'email'
end