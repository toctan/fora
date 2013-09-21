step 'I visit the homepage' do
  visit '/'
end

step 'I visit sign in page' do
  visit new_user_session_path
end
