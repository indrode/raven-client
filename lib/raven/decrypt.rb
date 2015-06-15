#!/usr/bin/env ruby

# DECRYPT
# clients can decrypt messages addressed to them
# using their own private/public keypair

require 'openssl'

module Raven
  class Decrypt
    attr_reader :destination, :timestamp

    def initialize(destination, timestamp)
      @destination = destination
      @timestamp = timestamp
    end

    def decrypt!
      private_key = OpenSSL::PKey::RSA.new(File.read(private_keyfile), password)
      cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
      cipher.decrypt

      # 1. get encrypted data from Store
      encrypted_data = data[:encrypted_data]
      encrypted_key = data[:encrypted_key]
      encrypted_iv = data[:encrypted_iv]

      # 2. decrypt the encrypted keys and IVs
      cipher.key = private_key.private_decrypt(encrypted_key)
      cipher.iv = private_key.private_decrypt(encrypted_iv)

      # 3. decrypt the encrypted_data
      decrypted_data = cipher.update(encrypted_data)
      decrypted_data << cipher.final

      decrypted_data
    end

    private

    def data
      Raven::Store.read(destination, timestamp)
    end

    def password
      Raven::Keystore.password
    end

    def private_keyfile
      Raven::Keystore.private_keyfile
    end
  end
end
