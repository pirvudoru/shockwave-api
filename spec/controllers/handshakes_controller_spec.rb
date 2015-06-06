require 'spec_helper'

describe HandshakesController do
  describe 'POST#create' do
    let(:handshake_params) { {timestamp: '2015-06-05T13:26:37Z', location: [45,45]} }
    let(:params) { {format: :json, handshake: handshake_params} }

    subject { post :create, params }

    context 'the user id for an existing user is given in the headers' do
      let!(:user) { User.create!({name: 'test'}) }
      before {  request.env['ACCESS_TOKEN'] = user.id }

      its(:status) { is_expected.to eq(201) }

      it 'creates a Handshake' do
        expect { subject }.to change { user.reload.handshakes.count }.by(1)
      end

      it 'stores the correct handshake timestamp' do
        subject

        expect(created_handshake.timestamp).to eq(DateTime.new(2015,06,05,13,26,37))
      end

      it 'stores the correct handshake location' do
        subject

        expect(created_handshake.location).to eq([45,45])
      end

      context 'the params contain some accelerometer entries' do
        before { params[:handshake][:acceleration_entries] = [{x: 1, y: 2, z: 3}] }

        it 'creates associated accelerometer entries for the new handshake' do
          subject

          expect(created_handshake.acceleration_entries.count).to be(1)
        end
      end

      def created_handshake
        user.reload.handshakes.last
      end
    end

    context 'an invalid user id is given as the access token' do
      before { request.headers['ACCESS_TOKEN'] = -1 }

      its(:status) { is_expected.to eq(401) }
    end
  end
end