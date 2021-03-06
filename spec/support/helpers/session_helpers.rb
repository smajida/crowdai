RSpec.configure do

  def is_not_authorized
    expect(response).to have_http_status(401)
    expect(response.body).to eql 'You are not authorized to access this page.'
  end

  def api_not_authorized
    expect(response).to have_http_status(401)
    expect(response.body).to eql "HTTP Token: Access denied.\n"
  end

  def asks_to_sign_in
    expect(response).to redirect_to sign_in_path
    expect(flash[:info]).to match(/You need to sign in or sign up before continuing./)
  end

  def denies_access
    expect(response).to have_http_status(401)
    expect(flash[:info]).to match(/You are not authorized to access this page./)
  end
end
