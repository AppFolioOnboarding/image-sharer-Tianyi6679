require 'uri'

class Image < ApplicationRecord
  validates :title, length: { minimum: 5 }

  validates :url, format: {
    with: URI.regexp(%w[http https])
  }

  acts_as_taggable_on :tags

  validates :tag_list, presence: true
end
