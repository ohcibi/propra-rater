require 'net-ldap'

class Ldap
  def initialize funkident, funkpw, host
    @funkident = funkident
    @funkpw = funkpw
    @host = host
  end

  # TODO: check if user is a propra tutor
  # ldap.search base: "CN=propra-tutoren,OU=OpenVPN,OU=Zentrale Services,OU=Heinrich-Heine-Universität,DC=AD,DC=hhu,DC=de"
  # ldap.search base: "CN=Ebbinghaus\\, Bj\xC3\xB6rn (bjebb100),OU=IDMUsers,DC=AD,DC=hhu,DC=de"
  def authenticate? ident, password
    ldap = Net::LDAP.new host: @host
    ldap.auth "#{ident}@AD.hhu.de", password

    begin
      ldap.bind
    rescue Net::LDAP::BindingInformationInvalidError
      false
    end
  end
end
