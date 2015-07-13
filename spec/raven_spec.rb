require "spec_helper"

module Raven
  describe '.encrypt' do
    let(:e) { double(:encryptor_instance) }
    let(:encrypted_data) { double(:encrypted_data) }

    it "creates Raven::Encrypt instance" do
      expect(Raven::Encrypt).to receive(:new).with('winterfell', 'Eddard Stark is dead!').and_return(e)
      expect(e).to receive(:encrypt).and_return(encrypted_data)
      expect(e).to receive(:store!).with(encrypted_data).and_return true

      expect(Raven::Order.encrypt!('winterfell', 'Eddard Stark is dead!')).to be(true)
    end
  end

  describe '.decrypt' do
    let(:d) { double(:decryptor_instance) }
    let(:decrypted_data) { double(:decrypted_data) }

    it "creates Raven::Encrypt instance" do
      hash = {
        timestamp: 'timestamp',
        message: decrypted_data
      }
      expect(Raven::Decrypt).to receive(:new).with('winterfell', 'timestamp').and_return(d)
      expect(d).to receive(:decrypt!).and_return(decrypted_data)

      expect(Raven::Order.decrypt!('winterfell', 'timestamp')).to eq(hash)
    end
  end
end
