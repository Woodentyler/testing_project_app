require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  subject(:user) do
    user.create!('steve', '123456')
  end

  describe "GET #show" do
    it "should render the show view" do
      get :show, params: {id: user.id}
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    it "should render the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "renders the new template after failed signup attempt" do
        post :create, params: { user: {
            username: 'stevesie',
            password: ''
          }
        }

        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end

end
