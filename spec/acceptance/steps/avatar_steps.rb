step 'I upload a(n) :type image' do |type|
  attach_file 'Avatar',
  type == 'illegal' ? "spec/assets/#{type}.txt" : "spec/assets/#{type}.jpg"

  click_button 'Update'
end
