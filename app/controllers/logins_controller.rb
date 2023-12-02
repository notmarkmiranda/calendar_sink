class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to login_path, alert: 'authentication_failed'
    end
  end

  private

  def authenticate_with_google
    if id_token = flash["google_sign_in"]["id_token"]
      google_identity = GoogleSignIn::Identity.new(id_token)
      User.find_or_initialize_by(google_id: google_identity.user_id).tap do |u|
        u.email = google_identity.email_address
        u.email_verified = google_identity.email_verified?
        u.avatar_url = google_identity.avatar_url
        u.save
      end
    elsif error = flash[:google_sign_in][:error]
      logger.error "Google authentication error: #{error}"
      nil
    end
  end
end