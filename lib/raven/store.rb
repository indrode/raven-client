module Raven
  class Store
    class << self
      def read(destination, timestamp)
        # reads stored data for a destination/timestamp
      end

      def write(destination, timestamp, encrypted_data, encrypted_key, encrypted_iv)
        # writes encrypted data for a destination/timestamp
      end
    end
  end
end
