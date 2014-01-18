class Cat < ActiveRecord::Base
  has_many :books, dependent: :destroy
  validates :decription, presence: true, length: { maximum: 40 }, uniqueness: true
end
