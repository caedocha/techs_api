module Authorization
  def authorize(user)
    token = Token.encode({ user_id: user.id })
    headers = { 'Authorization': "Bearer #{token}"}
    request.headers.merge!(headers)
  end
end
