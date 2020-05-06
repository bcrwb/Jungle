require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject {
    described_class.new(email: "check@check.COM", first_name: "check", last_name: "thisout", password: "password", password_confirmation: "password")
  }
  
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid when password confirmation does not match' do
      subject.password_confirmation = "wrong"
      expect(subject).to be_invalid
    end

    it 'is invalid when password not given in both fields' do
      subject.password_confirmation = nil
      expect(subject).to be_invalid
    end

    it "is invalid when email already exists in the database" do
      subject.save!
      @user = User.new(email: "check@check.com", first_name: "check", last_name: "thisout", password: "password", password_confirmation: "password")
      expect(@user).to be_invalid
    end

    it "is invalid when email not given" do
      subject.email = nil
      expect(subject).to be_invalid
    end

    it "is invalid when first_name not given" do
      subject.first_name = nil
      expect(subject).to be_invalid
    end

    it "is invalid when last_name not given" do
      subject.last_name = nil
      expect(subject).to be_invalid
    end
    
    it "is invalid when password length is < 4" do
      subject.password = "try"
      subject.password_confirmation = "try"
      expect(subject).to be_invalid
    end
  end

  describe ".authenticate_with_credentials" do
    before(:each) do 
      subject.save!
    end

    it "should be valid if credentials match" do
      user = User.authenticate_with_credentials(subject.email, subject.password)
      expect(user).to be_instance_of(User)
      expect(user.id).to eq(subject.id)
    end

    it "should be valid if email cases do not match exactly" do
        user = User.authenticate_with_credentials("test@test.com", subject.password)
        expect(user).to be_instance_of(User)
        expect(user.id).to eq(subject.id)
      end

      it "should be invalid if email doesn't match" do
        user = User.authenticate_with_credentials("matt.taylor@gmail.com", subject.password)
         expect(user).not_to be_instance_of(User)
      end

    it "should be invalid if password doesn't match" do
      user = User.authenticate_with_credentials(subject.email, "239529")
      expect(user).not_to be_instance_of(User)
    end

   

   

   
  end
end