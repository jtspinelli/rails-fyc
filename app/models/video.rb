class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :video_id, type: String

  belongs_to :user
end

