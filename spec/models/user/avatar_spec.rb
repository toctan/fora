require 'spec_helper'

describe User do
  it { should have_attached_file(:avatar) }
  it { should validate_attachment_size(:avatar).less_than(2.megabytes) }

  it { should validate_attachment_content_type(:avatar)
                .allowing('image/png', 'image/jpg', 'image/jpeg')
                .rejecting('image/gif') }
end
