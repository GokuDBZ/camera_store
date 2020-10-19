class Category < ApplicationRecord
    TYPE = ["mirrorless", "full frame", "point and shoot"]
    has_many :products
    validates :category_type , :inclusion => { :in => TYPE , :message => "Type must be within #{TYPE}"}
end
