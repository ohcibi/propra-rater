require './lib/ldap'

helpers do
  def protect!
    return if authorized?
    halt 401, "Not authorized\n"
  end

  def authorized?
    user = User.find_by token: request.env["HTTP_X_PROPRA_KEY"]
    if not user.nil? and user.token_is_valid?
      user.update_token_expiration!
      true
    else
      false
    end
  end

  def authenticate? ident, password
    raise "Please export $funkident with the functional ident" unless ENV["funkident"]
    raise "Please export $funkpw with the functional password" unless ENV["funkpw"]
    raise "Please export the ldap host as $ldaphost" unless ENV["ldaphost"]

    ldap = Ldap.new ENV["funkident"], ENV["funkpw"], ENV["ldaphost"]

    ldap.authenticate? ident, password
  end

  def authenticate! ident
    user = User.find_or_create_by ident: session["ident"]
    user.regenerate_token!
    user.token
  end

  def error401 response
    status 401
    json response
  end
end
