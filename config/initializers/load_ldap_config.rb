# LDAP_CONFIG = YAML.load_file("#{Rails.root}/config/ldap.yml")[Rails.env]
LDAP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/ldap.yml")).result)[Rails.env]
