require 'spec_helper'

RSpec.describe NewThreadsController, type: :controller do
  context 'user is guest' do

    before do
      @new_thread = NewThread.create(title: 'test thread', description: 'this is a test thread', user_id: 2)
    end

    it 'can see the index page' do
      get :index
      expect(response).to render_template('list')
    end

    describe 'GET #show' do
      it 'renders show template' do
        get :show, id: @new_thread.slug
        expect(response).to render_template('show')
      end
    end

    it 'can not see new thread page' do
      get :new
      expect(response).not_to render_template('show')
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'user is signed in' do

    describe 'allows new, create and show actions' do

      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = User.create(username: 'test_user', email: 'test@test.com', password: '12345',  password_confirmation: '12345')
        puts @user.id
        sign_in(@user)
      end

      it 'can see new thread page' do
        get :new
        expect(response).to render_template('new')
      end

      describe 'can create new threads' do
        it 'creates new thread' do
          post :create, new_thread: { title: 'test thread', description: 'this is a test thread', user_id: @user.id }
          #@user.reload
          expect(response).to redirect_to(@user.new_threads.first.urlbase)
        end
      end
    end
  end
end
