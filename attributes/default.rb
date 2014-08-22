# This version must be compatible with ruby-install definitions
default['ruby']['version']      = '2.1.2'
default['ruby']['prefix_path']  = '/usr/local'
default['ruby']['flavor']       = 'ruby'

case node['platform_family']
when 'debian', 'ubuntu'
  default['ruby']['required_pkgs'] =
    %w{ build-essential bison openssl libreadline6 libreadline6-dev
        zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0
        libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf
        ssl-cert libffi-dev cmake }
end
