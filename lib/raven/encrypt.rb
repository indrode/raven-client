#!/usr/bin/env ruby

# ENCRYPT
# clients can encrypt messages for a specific destination
# using the destination's public key

require 'openssl'
require 'base64'

module Raven
  class Encrypt
    attr_reader :destination, :plain_data

    def initialize(destination, plain_data)
      @destination = destination
      @plain_data = plain_data
    end

    def store!(hash)
      Raven::Store.write(
        destination,
        timestamp,
        hash[:encrypted_data],
        hash[:encrypted_key],
        hash[:encrypted_iv]
      )

      true
    end

    def encrypt!
      cipher ||= OpenSSL::Cipher::Cipher.new('aes-256-cbc')
      cipher.encrypt

      # 1. generate random keys and IVs used for encryption
      cipher.key = random_key = cipher.random_key
      cipher.iv = random_iv = cipher.random_iv

      # 2. encrypt it!
      encrypted_data = cipher.update(plain_data)
      encrypted_data << cipher.final

      # 3. encrypt the random keys and IVs
      public_key = OpenSSL::PKey::RSA.new(destination_keyfile)
      encrypted_key = Base64.encode64(public_key.public_encrypt(random_key))
      encrypted_iv = Base64.encode64(public_key.public_encrypt(random_iv))

      # 4. return encrypted data
      {
        encrypted_data: encrypted_data,
        encrypted_key: encrypted_key,
        encrypted_iv: encrypted_iv
      }
    end

    private

    def destination_keyfile
      File.read(Raven::Keystore.keyfile(destination))
    end

    def timestamp
      Time.now.to_i
    end
  end
end
