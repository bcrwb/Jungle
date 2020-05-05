require 'rails_helper'

RSpec.describe Product, type: :model do

    subject {
      described_class.new(name: "test", price: 200, quantity: 5)
    }
  
    describe 'Validations' do
      before(:each) do
        @category = Category.new(id: 1)
        subject.category = @category
      end
  
      after(:each) do
        puts subject.errors.full_messages
      end
  
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end
  
      it "is invalid with no name" do
        subject.name = nil
        expect(subject).to be_invalid
      end
  
      it "is invalid with no price" do
        subject.price_cents = nil
        expect(subject).to be_invalid
      end
  
      it "is invalid with no quantity" do
        subject.quantity = nil
        expect(subject).to be_invalid
      end
  
      it "is invalid with no category" do
        @category = nil
        subject.category = @category
        expect(subject).to be_invalid
      end
      
    end
  end