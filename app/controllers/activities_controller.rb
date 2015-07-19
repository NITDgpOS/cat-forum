class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    sleep 0.7
    @activities = PublicActivity::Activity.order('created_at desc')
                  .where(recipient_id: current_user)
                  .where('owner_id not in (?)', current_user)
                  .all
  end
end
