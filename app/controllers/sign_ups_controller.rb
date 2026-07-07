class SignUpsController < ApplicationController
  unauthenticated_access_only
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to sign_up_path, alert: "Try again later." }

  def create
    @user = User.new(sign_up_params)
    if @user.save!
      start_new_session_for(@user)
      redirect_to dashboard_path
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  private
    def sign_up_params
      params.expect(user: [ :username, :email_address, :password ])
    end
end
