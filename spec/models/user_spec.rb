require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name)}
    it { should validate_presence_of(:last_name)}
    it { should validate_presence_of(:gender)}
    it { should validate_presence_of(:age)}

    it do
      should validate_inclusion_of(:gender).
        in_array(['Male', 'Female', 'Other'])
    end

    it do
      should validate_numericality_of(:age)
    end
  end

  describe 'assocaitions' do
    it { should have_many(:bank_accounts) }
  end

  describe '#is_old_enough?' do
    before(:each) do
      @user = FactoryBot.create(:user, age: 20)
    end

    it 'returns true if user age greater than 16' do
      expect(@user.is_old_enough?).to eq(true)
    end

    it 'returns false if user age < 16' do
      @user.update(age: 3)
      expect(@user.is_old_enough?).to eq(false)
    end
  end

  describe '.by_age' do
    it 'orders users by their age ASC' do
      user_1 = FactoryBot.create(:user, age: 119)
      user_2 = FactoryBot.create(:user, age: 33)
      user_3 = FactoryBot.create(:user, age: 19)
      users = User.all.by_age
      expect(users.first.age).to eq(user_3.age)
      expect(users[1].age).to eq(user_2.age)
      expect(users.last.age).to eq(user_1.age)
    end
  end
end
