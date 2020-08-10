class Tech < ApplicationRecord
  has_many :links
  has_many :categories, -> { distinct }, through: :links

  validates :name, uniqueness: true
  validates :name, presence: true
end
