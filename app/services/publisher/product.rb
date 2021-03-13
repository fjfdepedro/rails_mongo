# frozen_string_literal: true
module Publisher
  class Product
    QUEUE_NAME = 'product'

    def initialize(product)
      @product = product
    end

    def publish
      channel = ::Publisher::BunnyPublisher.connection.create_channel
      exchange = channel.exchange(
        'product',
        type: 'direct',
        durable: true
      )
      exchange.publish(payload.to_s, persistent: true, routing_key: QUEUE_NAME)
    end

    private

    def payload
      {
        product: @product
      }
    end
  end
end
