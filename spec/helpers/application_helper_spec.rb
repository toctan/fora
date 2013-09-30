require 'spec_helper'

describe ApplicationHelper do
  describe '#avatar_tag' do
    it 'return avatar url for avatar_users' do
      avatar = double('avatar')
      user = double(:avatar? => true, username: 'test',
                    avatar: avatar)
      expect(avatar).to receive(:url)

      helper.avatar_tag(user)
    end

    it 'return gravatar url for user' do
      user = double(:avatar? => false,
                    email: 'test@me.com', username: 'test')
      expect(user).to receive(:email)

      helper.avatar_tag(user)
    end
  end
end
