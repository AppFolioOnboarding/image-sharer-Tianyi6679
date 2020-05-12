require 'uri'

class Image < ApplicationRecord
  validates :title, length: { minimum: 5 }

  validates :url, format: {
    with: URI.regexp(%w[http https])
  }
end
