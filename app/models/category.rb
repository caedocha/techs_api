class Category < ApplicationRecord
  has_many :links
  has_many :techs, -> { distinct }, through: :links

  validates :name, uniqueness: true
  validates :name, presence: true
end
