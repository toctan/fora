step 'I visit the homepage' do
  visit '/'
end

step 'I should see :msg message' do |msg|
  expect(page).to have_selector('.alert', text: msg)
end

step "I should see :msg helper block" do |msg|
  expect(page).to have_selector('p.help-block', text: msg)
end
