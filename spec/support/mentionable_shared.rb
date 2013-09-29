shared_examples_for Mentionable do

  subject { build described_class }

  describe '#after_create' do
    after(:each) { subject.save }

    it 'should not send notification when no one is mentioned' do
      expect(subject.notifications).not_to receive(:create)
    end

    it 'should send notifications to mentioned users' do
      mentioned_users = create_list(:user, 3)
      subject.body = mentioned_users.map { |u| "@#{u.username} " }.join

      mentioned_users.each do |u|
        expect(subject.notifications).to receive(:create).once.with(user: u)
      end
    end
  end
end
