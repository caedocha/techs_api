class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  attr_reader :current_user

  protected

  def authenticate_user!
    raise JWT::VerificationError unless user_id_in_token?

    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError => ex
    respond_to_unauthorized_error(ex)
  rescue JWT::DecodeError => ex
    respond_to_unauthorized_error(ex)
  rescue JWT::ExpiredSignature => ex
    respond_to_unauthorized_error(ex)
  rescue StandardError => ex
    respond_to_500_error(ex)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end

  def http_token
    return unless request.headers['Authorization'].present?

    request.headers['Authorization'].split(' ').last
  end

  def auth_token
    Token.decode(http_token)
  end

  def respond_to_unauthorized_error(ex)
    log_error(ex)
    render json: { msg: 'Bad credentials' }, status: 401
  end

  def respond_to_500_error(ex)
    log_error(ex)
    render json: {}, status: 500
  end

  def respond_to_duplicate_record_error(ex)
    log_error(ex)
    render json: { msg: 'Resource already exists' }, status: 409
  end

  def respond_to_not_found_error(ex)
    log_error(ex)
    render json: { msg: ex.message }, status: 404
  end

  def respond_to_missing_params_error(ex)
    log_error(ex)
    render json: { msg: ex.message }, status: 500
  end

  def log_error(ex)
    Rails.logger.error(ex.message)
    ex.backtrace.each { |line| Rails.logger.error(line) }
  end

end
