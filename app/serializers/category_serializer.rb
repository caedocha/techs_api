class CategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
  has_many :techs, serializer: TechSerializer
end
