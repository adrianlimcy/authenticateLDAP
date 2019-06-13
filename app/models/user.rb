class User < ApplicationRecord
  has_secure_password

  require 'net/ldap'

  def self.authenticate_ldap(login, password)
    ldap = Net::LDAP.new host: LDAP_CONFIG['host'],
                         port: LDAP_CONFIG['port'],
                         #encryption: :simple_tls,
                         base: LDAP_CONFIG['base'],
                        auth: {
                          method: :simple,
                          # username: "#{login}@rsp.ricoh.root",
                          username: "#{login}",
                          password: password
                         }
    group_mgr = false
    if ldap.bind
      user_array = []
      ldap.search(
        #base: LDAP_CONFIG['base'],
        filter: Net::LDAP::Filter.eq("mail", login),
        attributes:  [ "sAMAccountName", "division", "mail", "directReports" ]#,
        # return_result: true
      ) { |entry|
        user_array << entry.sAMAccountName.first
        user_array << entry.division.first
        user_array << entry.mail.first
        user_array << entry.directReports
      }
      ldap.search(
        filter: Net::LDAP::Filter.eq("mail", login)
      ) { |entry|
        entry.each do |attribute, values|
          if attribute.match(/memberof/)
            values.each do |value|
              a = value.split(',')
              md = a[0].match(/CN=(.+)/)

              if md[1] == 'Managers'
                group_mgr = true
              end
            end
          end
        end
        if group_mgr == true
          user_array << 'Manager'
        else
          user_array << 'Staff'
        end
      }
    end
    return user_array
    # return LDAP_CONFIG['port']
    # return ENV["AD_HOST"]
  end




end
