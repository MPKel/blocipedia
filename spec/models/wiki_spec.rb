require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) {User.create!(email: "fake@fake.com", password: "password123") }
  let(:wiki) { Wiki.create!(title: "New wiki Title", body: "New wiki Body", private: false, user: user) }

   describe "attributes" do
     it "has title and body attributes" do
       expect(wiki).to have_attributes(title: "New wiki Title", body: "New wiki Body")
     end
   end

end
