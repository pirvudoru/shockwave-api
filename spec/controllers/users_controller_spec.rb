require 'spec_helper'

describe UsersController do
  describe '#create' do
    let(:format) { :json }
    let(:params) { { format: format } }
    subject { post :create, params }

    its(:status) { is_expected.to eq(201) }
  end
end