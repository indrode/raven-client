require 'spec_helper'

module Raven
  class Store; end
end

RSpec.describe 'Raven::Encrypt' do
  let(:e) { Raven::Encrypt.new(:destination, 'message') }

  describe '#initialize' do
    it 'sets the correct instance values' do
      expect(e.destination).to eq(:destination)
      expect(e.plain_data).to eq('message')
    end
  end

  describe '#store!' do
    it 'writes to the Raven::Store' do
      allow(e).to receive(:timestamp).and_return 'timestamp'
      hash = {
        encrypted_data: 'encrypted data',
        encrypted_key: 'encrypted key',
        encrypted_iv: 'encrypted iv'
      }
      expect(Raven::Store).to receive(:write).with(:destination, 'timestamp', 'encrypted data', 'encrypted key', 'encrypted iv')
      expect(e.store!(hash)).to be_truthy
    end
  end

  describe '#encrypt!'
end
