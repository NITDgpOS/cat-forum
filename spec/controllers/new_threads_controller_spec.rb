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
      let(:new_thread) { create(:new_thread, user: user) }

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

      describe 'can edit new_threads' do
        it 'renders edit template' do
          get :edit, id: new_thread.slug
          expect(response).to render_template('edit')
        end

        it 'updates threads' do
          patch :update, id: new_thread.slug, new_thread: {
            title: 'test edit',
            description: 'just testing'
          }
          new_thread.reload
          expect(new_thread.slug).to eq('test-edit')
        end
      end

      it 'truncates slugs if more than 50 characters' do
        patch :update, id: new_thread.slug, new_thread: {
          title: 'test ' * 11
        }
        new_thread.reload
        expect(new_thread.slug).to eq('test-' * 10 + 't')
      end
    end
  end
end
