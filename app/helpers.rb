require './lib/ldap'

helpers do
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
end
