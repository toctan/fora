require 'spec_helper'

describe NodesController do
  describe 'GET show' do
    context 'when the node does not exist' do

      it 'redirects to the homepage' do
        allow(Node).to receive(:find_by).and_return(nil)
        get :show, key: 'key'
        expect(response).to redirect_to root_url
      end
    end
  end
end
