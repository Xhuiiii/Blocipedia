require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_wiki) {create(:wiki)}

  describe "attributes" do
  	it "Responds to title" do
  		expect(my_wiki).to respond_to(:title)
  	end

  	it "responds to body" do
  		expect(my_wiki).to respond_to(:body)
  	end
  end
end
