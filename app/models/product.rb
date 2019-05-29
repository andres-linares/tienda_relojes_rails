class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :brand

  has_paper_trail

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  # validates :images, presence: true
end
