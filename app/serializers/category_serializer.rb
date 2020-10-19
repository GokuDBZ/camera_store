class CategorySerializer
  include JSONAPI::Serializer
  has_many :products
  attributes
end
