require 'spec_helper'

describe User do
	before { @user = User.new(username:"test",email:"test@gmail.com",password:"password") }
	subject{ @user }

	it { should respond_to(:username) }
end
