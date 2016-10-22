json.extract! video, :id, :title, :path, :access_count, :created_at, :updated_at
json.url video_url(video, format: :json)