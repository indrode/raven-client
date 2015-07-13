require 'spec_helper'

RSpec.describe 'Raven::Decrypt' do
  let(:e) { Raven::Decrypt.new(:destination, 'timestamp') }

  describe '#initialize' do
    it 'sets the correct instance values' do
      expect(e.destination).to eq(:destination)
      expect(e.timestamp).to eq('timestamp')
    end
  end

  describe '#decrypt!'
end
