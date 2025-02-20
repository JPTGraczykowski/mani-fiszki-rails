class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Spróbuj ponownie później." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email, :password))
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Pomyślnie zalogowano."
    else
      redirect_to new_session_path, alert: "Niepoprawny e-mail lub hasło."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, notice: "Wylogowano."
  end
end
