class Users::RegistrationsController < Devise::RegistrationsController
  # Extend default Devise gem behavior so that
  # users signing up with the pro account (plan id 2)
  # save with a special Stripe subscription function
  # otherwise Devise signs up user as usual
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