require 'spec_helper'

describe HandshakeMatchJob do
  describe '#perform' do
    let(:instance) { HandshakeMatchJob.new }
    subject { instance.perform }

    context 'handshakes exist' do
      let!(:user1) { User.create!(name: 'First') }
      let!(:user2) { User.create!(name: 'Second') }

      before do
        user1.handshakes.create!(timestamp: Time.now + 11.seconds)
        user2.handshakes.create!(timestamp: Time.now + 12.seconds)
        user2.handshakes.create!(timestamp: Time.now + 11.seconds)
      end

      it 'adds user2 acquaintance to user1' do
        subject

        expect(user1.reload.acquaintances).to include(user2)
      end

      it 'adds user1 acquaintance to user2' do
        subject

        expect(user2.reload.acquaintances).to include(user1)
      end
    end
  end
end