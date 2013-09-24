require "spec_helper"

describe ApplicationHelper do
  describe "#avatar_url" do
    it "return avatar url for avatar_users" do
      user = double(:avatar? => true)
      user.stub_chain(:avatar, :url)
      user.should_receive(:avatar)

      helper.avatar_url(user)
    end

    it "return gravatar url for user" do
      user = double(:avatar? => false, email: "test@me.com")

      helper.avatar_url(user).should eq "http://gravatar.com/avatar/" \
      "8867aebd24d5d4809c3ab6fe4a0771e7.png?s=20&f=y&d=mm"
    end
  end
end
