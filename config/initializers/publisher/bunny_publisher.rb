# frozen_string_literal: true
require 'bunny'

module Publisher
  # Class to connect to rabbitmq properly, puma have threads
  class BunnyPublisher
    class << self

      def self.logger
        Rails.logger.tagged('bunny') do
          @logger ||= Rails.logger
        end
      end

      def connection
        @connection ||= begin
          instance = Bunny.new(
            addresses: 'rabbitmq:5672',
            username: 'guest',
            password: 'guest',
            vhost: '/',
            automatically_recover: true,
            connection_timeout: 2,
            continuation_timeout: 10_000,
            logger: Rails.logger
          )
          instance.start
          instance
        end
      end
    end
  end
end
