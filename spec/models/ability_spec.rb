require 'spec_helper'
require 'cancan/matchers'

describe 'User', type: :model do
  describe 'Abilities', type: :model do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }
    context 'when user is a guest' do
      let(:new_thread) { create(:new_thread) }
      let(:reply) { create(:reply) }

      it { should be_able_to(:index, NewThread) }
      it { should be_able_to(:list, new_thread) }
      it { should be_able_to(:search, new_thread) }
      it { should be_able_to(:show, new_thread) }
      it { should be_able_to(:index, Reply) }
      it { should be_able_to(:list, reply) }
      it { should be_able_to(:show, reply) }

      it { should_not be_able_to(:new, NewThread) }
      it { should_not be_able_to(:create, NewThread) }
      it { should_not be_able_to(:edit, new_thread) }
      it { should_not be_able_to(:update, new_thread) }
      it { should_not be_able_to(:destroy, new_thread) }
      it { should_not be_able_to(:new, Reply) }
      it { should_not be_able_to(:create, Reply) }
      it { should_not be_able_to(:edit, reply) }
      it { should_not be_able_to(:update, reply) }
      it { should_not be_able_to(:delete, reply) }
      it { should_not be_able_to(:destroy, reply) }
    end

    context 'when user is not owner of thread and reply' do
      let(:user) { create(:user) }
      let(:user2) { create(:user) }
      let(:new_thread) { create(:new_thread, user: user2) }
      let(:reply) { create(:reply, user: user2) }

      it { should be_able_to(:new, NewThread) }
      it { should be_able_to(:create, NewThread) }
      it { should be_able_to(:new, Reply) }
      it { should be_able_to(:create, Reply) }

      it { should_not be_able_to(:edit, new_thread) }
      it { should_not be_able_to(:update, new_thread) }
      it { should_not be_able_to(:destroy, new_thread) }
      it { should_not be_able_to(:edit, reply) }
      it { should_not be_able_to(:update, reply) }
      it { should_not be_able_to(:delete, reply) }
      it { should_not be_able_to(:destroy, reply) }
    end

    context 'when user is owner of thread and reply' do
      let(:user) { create(:user) }
      let(:new_thread) { create(:new_thread, user: user) }
      let(:reply) { create(:reply, user: user) }

      it { should be_able_to(:edit, new_thread) }
      it { should be_able_to(:update, new_thread) }
      it { should be_able_to(:destroy, new_thread) }
      it { should be_able_to(:edit, reply) }
      it { should be_able_to(:update, reply) }
      it { should be_able_to(:delete, reply) }
      it { should be_able_to(:destroy, reply) }
    end
  end
end
