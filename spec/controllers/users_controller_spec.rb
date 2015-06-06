require 'spec_helper'

describe UsersController do
  describe '#create' do
    let(:format) { :json }
    let(:params) { { format: format } }
    subject { post :create, params }

    context 'user parameters are defined' do
      before do
        params[:user] = {
            name: 'test',
            email: 'email@user.com',
            phone_number: '012345'
        }
      end

      its(:status) { is_expected.to eq(201) }

      it 'saves a new user' do
        expect { subject }.to change { User.count }.by(1)
      end

      it 'assigns name to user' do
        subject

        expect(User.last.name).to eq(params[:user][:name])
      end

      it 'assigns email to user' do
        subject

        expect(User.last.email).to eq(params[:user][:email])
      end

      it 'assigns phone_number to user' do
        subject

        expect(User.last.phone_number).to eq(params[:user][:phone_number])
      end

      it 'returns id in response body' do
        expect(JSON.parse(subject.body)['id']).not_to be_nil
      end
    end
  end
end