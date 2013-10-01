step 'I click :link( link)' do |link|
  click_link link
end

step 'I (am) on/visit (the ):page_name( page)' do |page_name|
  visit path_to(page_name)
end

step 'I should see :msg message' do |msg|
  expect(page).to have_selector('.alert', text: msg)
end

step 'I should see :msg helper hint' do |msg|
  expect(page).to have_selector('span.help-inline', text: msg)
end

step 'I should see :msg helper block' do |msg|
  expect(page).to have_selector('p.help-block', text: msg)
end
