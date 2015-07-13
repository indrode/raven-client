# The Store is the interface between the local client and the central server.
# It sends and receives message data to/from the central server via API requests.
# Authentication is done via a hashed combination of:
# - local location UUID
# - local name
# - timestamp
module Raven
  class Store
    class << self
      def read(destination, timestamp)
        # reads stored data for a destination/timestamp
      end

      def write(destination, timestamp, encrypted_data, encrypted_key, encrypted_iv)
        # writes encrypted data for a destination/timestamp
      end

      private

      def auth_token
        # use some hashing function
        "#{unkindness_name}#{unkindness_uuid}#{timestamp}"
      end

      def timestamp
        # this is minute-precision
        # server is taking into account that the request could reach the next minute
        Time.now.to_i.to_s[0..7]
      end
    end
  end
end
