# encoding: utf-8

class PostImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::Carrierwave

end
