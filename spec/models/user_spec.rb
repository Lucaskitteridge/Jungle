require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a user' do
      user = User.new(
        name: "Mona Lisa",
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: "hello"
        )
      expect(user).to (be_valid)
    end

    it 'should not create a user when password is empty' do
      user = User.new(
        name: nil,
        email: "MonaLisa@DaVinci.com",
        password: nil,
        password_confirmation: nil
        )
      expect(user).to_not (be_valid)
    end

    it 'should not create a user when password_confirmation is missing' do
      user = User.new(
        name: nil,
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: nil
        )
      expect(user).to_not (be_valid)
    end

    it 'should not create a user when missing a name' do
      user = User.new(
        name: nil,
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: "hello"
        )
      expect(user).to_not (be_valid)
    end

    it 'should not create a user when missing an email' do
      user = User.new(
        name: "Mona Lisa",
        email: nil,
        password: "hello",
        password_confirmation: "hello"
        )
      expect(user).to_not (be_valid)
    end

    it 'should not create a user when passwords do not match' do
      user = User.new(
        name: "Mona Lisa",
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: "goodbye"
        )
      expect(user).to_not (be_valid)
    end

    it 'should not save if the email already exists within the database' do
      user1 = User.new(
        name: "Mona Lisa",
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: "goodbye"
        )

      user2 = User.new(
        name: "Banksy",
        email: "monAlisA@dAvinci.com",
        password: "hello",
        password_confirmation: "goodbye"
        )
      expect(user2).to_not (be_valid)
    end

    it 'should not create a user when password is below 5 characters' do
      user = User.new(
        name: "Mona Lisa",
        email: "MonaLisa@DaVinci.com",
        password: "hi",
        password_confirmation: "hi"
        )
      expect(user).to_not (be_valid)
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should not authenticate when the email is not in database' do
      user = User.create(
        name: "Mona Lisa",
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: "hello"
        )
        params = { email: 'Banksy@DaVinci.com', password: 'hello' }
        user = User.authenticate_with_credentials(params[:email], params[:password])
      expect(user).to be_nil
    end

    it 'should not authenticate when the wrong password' do
      user = User.create(
        name: "Mona Lisa",
        email: "monalisa@DaVinci.com",
        password: "hello",
        password_confirmation: "hello"
        )
        params = { email: 'MonaLisa@DaVinci.com', password: 'goodbye' }
        user = User.authenticate_with_credentials(params[:email], params[:password])
      expect(user).to be_nil
    end
    it 'should authenticate when the cases are wrong' do
      user = User.create(
        name: "Mona Lisa",
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: "hello"
        )
        params = { email: 'monalISA@DaVinci.com', password: 'hello' }

        userfinder = User.find_by(email: "MonaLisa@DaVinci.com")

        user = User.authenticate_with_credentials(params[:email], params[:password])
        expect(userfinder).to eq user
    end
    it 'should authenticate when there are trailing spaces' do
      user = User.create(
        name: "Mona Lisa",
        email: "MonaLisa@DaVinci.com",
        password: "hello",
        password_confirmation: "hello"
        )
        params = { email: '   MonaLisa@DaVinci.com   ', password: 'hello' }

        userfinder = User.find_by(email: "MonaLisa@DaVinci.com")

        user = User.authenticate_with_credentials(params[:email], params[:password])
        expect(userfinder).to eq user
    end
  end
end