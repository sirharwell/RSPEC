require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  login_user

  let(:valid_attributes) {
    { institution: 'Chase', amount: 10000, active: true }
  }
  let(:invalid_attributes) {
    { institution: '', amount: 200, active: true }
  }

  describe "GET #index" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :show, params: {id: bank_account.id}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :edit, params: {id: bank_account.id}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new account" do
        expect {
          post :create, params: {bank_account: valid_attributes }
        }.to change(BankAccount, :count).by(1)
      end
      it "redirects to the created account" do
        post :create, params: {bank_account: valid_attributes }
        expect(response).to redirect_to(BankAccount.last)
      end
    end
    context "with invalid params" do
      it "does not create an account" do
        expect {
          post :create, params: {bank_account: invalid_attributes}
        }.to change(BankAccount, :count).by(0)
      end
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {bank_account: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  

















end
