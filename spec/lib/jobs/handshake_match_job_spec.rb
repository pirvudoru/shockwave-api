require 'spec_helper'

describe HandshakeMatchJob do
  describe '#perform' do
    let(:instance) { HandshakeMatchJob.new }
    subject { instance.perform }

    context 'handshakes exist' do
      let!(:user1) { User.create!(name: 'First') }
      let!(:user2) { User.create!(name: 'Second') }

      let!(:handshake1) { user1.handshakes.create!(timestamp: Time.now + 11.seconds, location: [45.784496, 24.171597]) }
      let!(:handshake2) { user2.handshakes.create!(timestamp: Time.now + 30.seconds, location: [45.784499, 24.171607]) }
      let!(:handshake3) { user2.handshakes.create!(timestamp: Time.now + 5.seconds, location: [45.784498, 24.171603]) }
      let!(:handshake4) { user2.handshakes.create!(timestamp: Time.now + 5.seconds, location: [47.784499, 23.171607]) }

      it 'adds user2 acquaintance to user1' do
        subject

        expect(user1.reload.acquaintances).to include(user2)
        expect(user1.reload.acquaintances.count).to eq(1)
      end

      it 'adds user1 acquaintance to user2' do
        subject

        expect(user2.reload.acquaintances).to include(user1)
        expect(user2.reload.acquaintances.count).to eq(1)
      end

      it 'deletes matched handshakes' do
        subject

        expect(user1.reload.handshakes.count).to eq(0)
        expect(user2.reload.handshakes).to match_array([handshake2, handshake4])
      end
    end
  end
end