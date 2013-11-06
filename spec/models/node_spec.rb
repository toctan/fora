require 'spec_helper'

describe Node do
  it { should have_many(:topics).dependent(:destroy) }

  it { should validate_presence_of(:key)  }
  it { should validate_presence_of(:name) }

  it { should have_db_index(:key) }
  it { should validate_uniqueness_of(:key).case_insensitive }
  it { should_not allow_value('@key').for(:key) }
  it { should allow_value('hellow-world').for(:key) }

  it { should ensure_length_of(:description).is_at_most(140) }

  it { should have_attached_file(:image) }
  it { should validate_attachment_size(:image).less_than(2.megabytes) }

  it { should validate_attachment_content_type(:image)
                .allowing('image/png', 'image/jpg', 'image/jpeg')
                .rejecting('image/gif') }
end
