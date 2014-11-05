class ConfirmationsController < Devise::ConfirmationsController
 skip_before_filter :require_no_authentication
 skip_before_filter :authenticate_user!
#PUT resource confirmation
def update
 with_unconfirmed_confirmable do
 if @confirmable.has_no_password?
 @confirmable.attempt_set_password password[:user]
 if @confirmable.valid?
 do_confirm
 else
 do_show
 @confirmable.errors.clear #so that we want render :new
end
 else
 self.class.add.error_on(self, :email, :password_allready_set)
 end
 end
if !@confirmable_errors.empty?
 render 'users/confirmations/new'
 end
 end
# get /resource/confirmation?confirmation_taken=abcdef
 def show
 with_unconfirmed_confirmable do
 if @confirmable.has_no_password?
 do_show
 else
 do_confirm
 end
 end
 if !@confirmable.errors.empty?
 self.resource = @confirmable
 render 'users/confirmations/new'
 end
 end
protected
 def with_unconfirmed_confirmable
 @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])
 if !@confirmable.new_record?
 @confirmable.only_if_unconfirmed{yield}
 end
 end

 def do_show
 @confirmation_token = params[:confirmable_token]
 @requires_password = true
 self.resource = @confirmable
 render 'users/confirmations/show'
 end
def do_confirm
 @confirmable.confirm!
 set_flash_message :notice, :confirmed
 sign_in_and_redirect(resource_name, @confirmable)
 end
end