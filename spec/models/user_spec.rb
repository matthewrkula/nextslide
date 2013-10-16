require 'spec_helper'

describe User do
  [ :id, :email, :password, :password_digest,
    :password_confirmation, :created_at, :updated_at ].each do |field|
    it { should respond_to field }
  end
 
  [ :email, :password, :password_confirmation ].each do |field|
    it { should allow_mass_assignment_of field }
  end

  [ :id, :password_digest, :created_at, :updated_at ].each do |field|$$
    it { should_not allow_mass_assignment_of field }
  end

  [ :email, :password_digest ].each do |field|
    it { should validate_presence_of field }
  end

  [ :email ].each do |field|
    it { should validate_uniqueness_of field }
  end

  it { should ensure_length_of(:password).is_at_least(8) }

  context 'password presence/length validation' do
    context 'when the user is newly created' do
      it 'should require password presence' do
        user = build(:user, password: '', password_confirmation: '')
        user.should_not be_valid
        user.errors[:password].should include("is too short (minimum is 8 characters)")
      end 
    end

    context 'when the user already exists' do
      context 'when the password is blank' do
        it 'should not require password to be filled out' do
          user = User.create!({
            email: Faker::Internet.email,
            password: '12345678',
            password_confirmation: '12345678'
          })
          user = User.find(user)
          user.password = ''
          user.password_confirmation = ''
          user.should be_valid
        end
      end

      context 'when the password is not blank' do
        it 'should validate its presence' do
          user = create(:user, password: '12345678', password_confirmation: '12345678')
          user.password = 'a'
          user.should_not be_valid
          user.errors[:password].should include("is too short (minimum is 8 characters)")
        end
      end
    end
  end

  context '#validate_password?' do
    context 'when new_record? is true' do
      it 'should return true' do
        user = create(:user)
        user.should_receive(:new_record?).and_return(true)
        user.validate_password?.should be_true
      end
    end

    context 'when #password.present? is true' do
      it 'should return true' do
        user = create(:user)
        user.password.should_receive(:present?).and_return(true)
        user.validate_password?.should be_true
      end
    end

    context 'when #password_confirmation.present? is true' do
      it 'should return true' do
        user = create(:user)
        user.password.stub(:present?).and_return(false)
        user.password_confirmation.should_receive(:present?).and_return(true)
        user.validate_password?.should be_true
      end
    end
  end

  it 'should be able to create an user with valid attributes' do
    User.create({
      email: Faker::Internet.email, 
      password: '123456789', 
      password_confirmation: '123456789'
    }).should be_true
  end
end
