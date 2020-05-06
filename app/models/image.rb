class Image < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }

  validates :url, presence: true, format: {
    with: /\.(png|jpg|jpeg|svg|gif|bmp|tiff|exif)\Z/i,
    message: 'Please enter a valid URL'
  }
end
