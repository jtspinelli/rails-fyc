class Users
  # Returns user found by the given provider uid
  # @param provider_id [String] the id from authentication provider
  # @return [Mongoid::Document, nil] the found user, otherwise nil
  def self.find_user(provider_id)
    User.find_by(provider_id: provider_id)
  end

  # Verifies if database already contains the user with given provider id
  # @param provider_id [String] the id from authentication provider
  # @return [Boolean] true or false
  def self.user_in_db?(provider_id)
    User.where(provider_id: provider_id).exists?
  end

  # Returns the developer user from database
  # @return [Mongoid::Document, nil] the developer user document, otherwise nil
  def self.developer
    User.find_by(provider_id:"00001")
  end

  # Updates user token saved in database with given user info
  # @param user_info [Rack::Request::Env] the request environment containing user info
  # @return [Mongoid::Document, nil] the updated user, otherwise nil
  def self.update_user(user_info)
    user = find_user(user_info.uid)
    user.update_attributes(
      token: user_info.credentials.token,
      refresh_token: user_info.credentials.refresh_token,
      expires_at: Time.at(user_info.credentials.expires_at).to_datetime
    )
    find_user(user_info.uid)
  end

  # Creates a new User with the given auth provider user info
  # @param [Rack::Request::Env] the request environment containing user info
  # @return [Mongoid::Document, Array, nil] the created User, otherwise nil
  def self.create_new_user(user_info)
    User.create(
      provider_id: user_info.uid,
      provider: user_info.provider,
      name: user_info.info.name,
      first_name: user_info.info.first_name,
      last_name: user_info.info.last_name,
      email: user_info.info.email,
      token: user_info.credentials.token,
      refresh_token: user_info.credentials.refresh_token,
      expires_at: Time.at(user_info.credentials.expires_at).to_datetime
    )
  end
end
