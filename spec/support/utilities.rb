include ApplicationHelper

def sign_in_as(type)
  user = create(type)
  sign_in user
  return user
end
