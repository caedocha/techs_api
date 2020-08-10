class LinkSerializer
  include FastJsonapi::ObjectSerializer
  attributes :category_id, :tech_id
  has_one :tech
  has_one :category
end
