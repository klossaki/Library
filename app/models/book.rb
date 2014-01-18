class Book < ActiveRecord::Base
  belongs_to :cat
  belongs_to :author
  validates :title, presence: true, length: { maximum: 40 }, uniqueness: true
  validates :isbn, length: { maximum: 10 }, uniqueness: true
  validates :author_id, :cat_id, :copies, presence: true
  validates :copies, presence: true, numericality: { only_integer: true }
  validates :rank, presence: true, numericality: { only_integer: true }
end
