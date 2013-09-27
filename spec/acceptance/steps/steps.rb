step 'I visit the homepage' do
  visit '/'
end

step "I click :link" do |link|
  click_link link
end

step "I visit :link" do |link|
  visit link
end

step 'I should see :msg message' do |msg|
  expect(page).to have_selector('.alert', text: msg)
end

step "I should see :msg helper hint" do |msg|
  expect(page).to have_selector('span.help-inline', text: msg)
end

step "I should see :msg helper block" do |msg|
  expect(page).to have_selector('p.help-block', text: msg)
end
