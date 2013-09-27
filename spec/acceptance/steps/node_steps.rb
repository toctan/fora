module NodeSteps
  step 'there exists a node' do
    @node = FactoryGirl.create(:node)
  end

  step 'there exists a :name node with a dozen of topics' do |name|
    FactoryGirl.create(:node, name: name) do |node|
      @topic = FactoryGirl.create_list(:topic, 7, node: node).sample
    end
  end

  step 'I (am) on/visit this node\'s new topic page' do
    visit "/new/#{@node.key}"
  end

  step 'I should see all these topics' do
    expect(page).to have_selector('.topic a', text: @topic.title)
  end

end

RSpec.configure { |c| c.include NodeSteps }
