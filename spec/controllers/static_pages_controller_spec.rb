require "spec_helper"

describe StaticPagesController do

	describe ":index"	do
		it "should have index action"	do
			get :index		
			expect(response).to be_success
		end
	end

end