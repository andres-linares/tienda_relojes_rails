class Purchase < ApplicationRecord
  validates :address, presence: true
  validates :telephone, presence: true

  belongs_to :product
  belongs_to :user
end
