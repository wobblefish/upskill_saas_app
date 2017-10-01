class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          # pro user
          resource.save_with_subscription
        else
          # basic user
          resource.save
        end
      end
    end
  end
end