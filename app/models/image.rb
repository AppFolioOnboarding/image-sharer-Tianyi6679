require 'uri'

class Image < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }

  validates :url, format: {
    with: URI.regexp(%w[http https]),
    message: 'Please enter a valid URL'
  }
end
