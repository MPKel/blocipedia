require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "user@bloccit.com", password: "password") }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes( email: "user@bloccit.com")
      #expect(user).to have_attributes(name: user.name, email: user.email)
    end
  end

end
