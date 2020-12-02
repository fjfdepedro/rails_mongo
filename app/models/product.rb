class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :detail, type: String
  field :price, type: Integer
end
