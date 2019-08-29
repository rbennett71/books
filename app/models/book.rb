class Book < ApplicationRecord
  validates :isbn,  presence: true, uniqueness: true
  validates :title, presence: true

  scope :by_author, -> (author) { where(author_last_name: author) }
end
