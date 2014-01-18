class Author < ActiveRecord::Base
  has_many :books, dependent: :destroy
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: true
end
