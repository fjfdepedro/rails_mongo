
class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :detail, type: String
  field :price, type: Integer

  after_save :publish_to_dashboard

  private

  def publish_to_dashboard
    Rails.logger.error("-----------------#{attributes.inspect}")
    Publisher::Product.new(attributes).publish
  end
end
