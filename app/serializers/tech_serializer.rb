class TechSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
  has_many :categories
end
