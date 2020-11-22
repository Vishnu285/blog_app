module AuthHelper
  def http_login
    user = 'test@test.com'
    pw = 'test'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end  
end