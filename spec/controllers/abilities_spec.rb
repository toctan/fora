require 'spec_helper'
require 'cancan/matchers'

describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when user is admin" do
      let(:user){ sign_in_as(:admin) }

      it{ should be_able_to(:manage, :all) }
    end

    describe "on topic" do
      context "when user is guest" do
        it{ should be_able_to(:read, Topic)}

        it{ should_not be_able_to(:create, Topic)}
        it{ should_not be_able_to(:unstar, Topic)}
        it{ should_not be_able_to(:star, Topic)}
      end

      context "when user is normal" do
        let(:user){ sign_in_as(:confirmed_user) }

        it{ should be_able_to(:read, Topic) }
        it{ should be_able_to(:create, Topic) }
        it{ should be_able_to(:star, Topic) }
        it{ should be_able_to(:unstar, Topic) }

        it{ should_not be_able_to(:destroy, Topic) }
      end
    end
  end
end
