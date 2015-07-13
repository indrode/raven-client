require 'raven/version'
require 'raven/encrypt'
require 'raven/decrypt'

module Raven
  def encrypt!(destination, data)
    e = Raven::Encrypt.new(destination, data)
    e.store!(e.encrypt)
  end

  def decrypt!(destination, timestamp)
    d = Raven::Decrypt.new(destination, timestamp)
    { timestamp: timestamp, message: d.decrypt! }
  end
end
