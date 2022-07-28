class YoutubeApi
  # Calls Youtube API for data from given video id and returns the response
  # @param video_id [String] the video id
  # @return [Net::HTTPResponse] the api http response
  def self.look_for_video(video_id)
    base_address = "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails&id="
    youtube_api_key = Rails.application.credentials.dig(:youtube, :key)
    request_url = URI(base_address + video_id + "&key=" + youtube_api_key)

    @response = Net::HTTP.get_response(request_url)
    @response
  end

  # Gets data from Youtube API and returns a Hash containing video id, title, channel and thumbnail url from the given youtube video id
  # @param video_id [String] the youtube video id
  # @return [Hash] Hash containing video id, title, channel and thumbnail url
  def self.resolve_video_data(video_id)
    request_res = look_for_video(video_id)

    video_data = JSON.parse(request_res.body)["items"][0]["snippet"]
    video_title = video_data["title"]
    video_thumb_url = video_data["thumbnails"]["high"]["url"]
    video_channel = video_data["channelTitle"]

    {"title" => video_title,
     "thumb-url" => video_thumb_url,
     "channel" => video_channel,
     "video_id" => video_id,
      "url" => "https://www.youtube.com/watch?v=" + "video_id"
    }
  end

  # Returns the video id extracted from given url
  # @param url [String] the url to extract video id from
  # @return [String] the video id
  def self.resolve_video_id(url)
    trace = url.split("watch?v=")[1]
    trace.split("&")[0] unless trace.nil?
  end

  # Verifies if Youtube API response contains data from a found video
  # @return [Boolean] true or false
  def self.video_found?
    JSON.parse(@response.body)["items"].size > 0
  end
end
