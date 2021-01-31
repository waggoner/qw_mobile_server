module ApiSessions
  extend ActiveSupport::Concern

  def api_user
    @api_user
  end

  private

  def authenticate_api_request!
    unless valid_api_token?
      forbidden_request!(:unauthorized)
    end
  end

  def valid_api_token?
    if request.headers['X-API-KEY'].present?
      request.headers['X-API-KEY'] == Rails.application.credentials.api[:app_key]
    else
      false
    end
  end

  def authenticate_api_user!
    unless valid_api_user?
      forbidden_request!(:unauthorized)
    end
  end

  def valid_api_user?
    return false unless request.headers['Authorization'].present?
    token = request.headers['Authorization'].split(' ').last.gsub(/token=/, "")
    @api_user = User.find_by_api_key(token)
  end
end