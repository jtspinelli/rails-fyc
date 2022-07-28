class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :provider_id, type: String
  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :token, type: String
  field :refresh_token, type: String
  field :expires_at, type: String

  has_many :videos
end