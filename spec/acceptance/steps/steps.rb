step 'I visit the homepage' do
  visit '/'
end

step 'I should see :msg message' do |msg|
  expect(page).to have_selector('.alert', text: msg)
end

step 'I visit sign in page' do
  visit new_user_session_path
end
