# encoding: utf-8
require 'streamio-ffmpeg'

class VideoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick


  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "video.mp4" if original_filename
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :screenshot do
    process :screenshot
    def full_filename (for_file = model.logo.file)
      "screenshot.jpg"
    end
  end

  def screenshot
    tmp_file = File.join(File.dirname(current_path), "tmpfile")

    File.rename(current_path, tmp_file)
    tmp_file.slice!(Rails.root.to_s + "/")
    image_file = current_path.to_s
    image_file.slice!(Rails.root.to_s + "/")

    movie = FFMPEG::Movie.new(tmp_file)
    movie.screenshot(image_file + ".jpg",{ seek_time: 5, :resolution => '500x300'}, preserve_aspect_ratio: :width)
    File.rename(image_file + ".jpg", current_path)

    File.delete(tmp_file)
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(mp4)
  end

end
