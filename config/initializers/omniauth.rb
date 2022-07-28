
# Redirect in case user cancels authentication from Twitter
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider(
    :twitter2,
    Rails.application.credentials.dig(:twitter, :client_id),
    Rails.application.credentials.dig(:twitter, :client_secret),
    callback_path: '/auth/twitter2/callback',
    scope: 'tweet.read users.read bookmark.read offline.access'
  )
  provider(
    :google_oauth2,
    Rails.application.credentials.dig(:google, :client_id),
    Rails.application.credentials.dig(:google, :client_secret),
    {
      scope: 'email, profile',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
      image_size: 50,
      :skip_jwt => true
    }
  )
  provider(
    :facebook,
    Rails.application.credentials.dig(:facebook, :app_id),
    Rails.application.credentials.dig(:facebook, :app_secret),
    {
      scope: "email, public_profile",
      auth_type: 'reauthenticate'
    }
  )
end


