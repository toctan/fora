require 'spec_helper'

describe UsersFetcher do
  subject(:fetcher) { UsersFetcher.new([[1, nil, nil], [2, [3, 4], 5]]) }

  describe '#initialize' do
    it 'sets the user_ids properly' do
      user_ids = fetcher.instance_variable_get(:@user_ids)

      expect(user_ids).to eq [1, 2, 3, 4, 5]
    end
  end

  describe '#[]' do
    let(:user) { build(:user).tap {|u| u.id = 1} }

    it 'returns an user object' do
      User.stub_chain('where.select').and_return([user])

      fetched_user = fetcher[1]
      expect(fetched_user).to be_a(User)
      expect(fetched_user.id).to eq 1
    end
  end
end
