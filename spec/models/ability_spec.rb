require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { Ability.new(user) }

  context 'as a guest' do
    let(:user) { nil }

    it { should be_able_to(:read, :all) }
    it { should_not be_able_to(:create, Topic) }
  end

  context 'as a member' do
    let(:user) { build(:user) }

    it { should be_able_to(:create, Topic) }
    it { should be_able_to(:create, Reply) }

    it { should_not be_able_to(:destroy, Topic) }
    it { should_not be_able_to(:destroy, Reply) }
  end

  context 'as admin' do
    let(:user) { build(:admin) }

    it { should be_able_to(:destroy, Topic) }
    it { should be_able_to(:destroy, Reply) }
  end
end
