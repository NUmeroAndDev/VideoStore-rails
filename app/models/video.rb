class Video < ApplicationRecord
  mount_uploader :path, VideoUploader

  validates :title, :path, :presence => true
end
