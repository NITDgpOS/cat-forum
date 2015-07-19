require 'spec_helper'

describe NewThreadsController do
  let(:new_thread) { create(:new_thread) }

  context 'user is guest' do
    it 'can see the index page' do
      get :index
      expect(response).to render_template('list')
    end

    describe 'GET #show' do
      it 'renders show template' do
        get :show, id: new_thread.slug
        expect(response).to render_template('show')
      end
    end

    it 'can not see new thread page' do
      get :new
      expect(response).not_to render_template('new')
    end
  end

  context 'user is signed in' do
    describe 'allows new, create and show actions' do
      let(:user) { create(:user) }
      before { sign_in(user) }

      it 'can see new thread page' do
        get :new
        expect(response).to render_template('new')
      end

      describe 'can create new threads' do
        it 'creates new thread' do
          post :create, new_thread: {
            title: new_thread.title,
            description: new_thread.description,
            user_id: user.id
          }
          expect(user.new_threads).not_to be_empty
        end
      end
    end
  end
end
