class ProductSerializer
  include JSONAPI::Serializer
  belongs_to :category
  attributes 
end
