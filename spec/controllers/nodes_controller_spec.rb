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

  describe 'GET new' do
    context 'when the user is not signed in' do
      it 'redirects the user to the sign in page' do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
