module Admin
  class UsersController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement
    # custom behavior
    # For example, you may want to send an email after a foo is updated.

    def update
      if params[:user][:password].blank?
        params[:user].delete :password
        params[:user].delete :password_confirmation
      end
      super
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.

    def find_resource(param)
      User.find_by!(id: param)
    end

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.

    # def scoped_resource
    #  if current_user.super_admin?
    #    resource_class
    #  else
    #    resource_class.with_less_stuff
    #  end
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
