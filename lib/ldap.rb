require 'net-ldap'

PROPRA_TUTOREN_CN="CN=propra-tutoren,OU=OpenVPN,OU=Zentrale Services,OU=Heinrich-Heine-Universität,DC=AD,DC=hhu,DC=de"

USERS_OU="OU=IDMUsers,DC=AD,DC=hhu,DC=de"

ACC_NAME="sAMAccountName"

class UserNotFoundException < Exception; end
class UserNoPropraTutorException < Exception; end
class WrongPasswordException < Exception; end

class Ldap
  def initialize funkident, funkpw, host
    @funkident = funkident
    @funkpw = funkpw
    @host = host
  end

  def authenticate? ident, password
    ldap = Net::LDAP.new host: @host
    ldap.auth "#{@funkident}@AD.hhu.de", @funkpw

    userident = "#{ident}@ad.hhu.de"

    user = find_user ldap, ident

    raise UserNotFoundException if user.nil?
    raise UserNoPropraTutorException unless propra_member ldap, user
    raise WrongPasswordException unless bound ldap, userident, password

    true
  end
end

def find_user ldap, ident
  ldap.search(base: USERS_OU, filter: Net::LDAP::Filter.eq(ACC_NAME, ident))[0]
end

def bound ldap, userident, password
  begin
    ldap.bind method: :simple, username: userident, password: password
  rescue Net::LDAP::BindingInformationInvalidError
    false
  end
end

def propra_member ldap, user
  # the encoding of the group name strings is broken, maybe due to the ldap library
  # this is a problem for string comparison because of universit"ä"t in PROPRA_TUTOREN_CN
  membersOf = user.memberOf.map do |group|
    group.encode("ascii-8bit").force_encoding "utf-8"
  end

  membersOf.include? PROPRA_TUTOREN_CN
end
