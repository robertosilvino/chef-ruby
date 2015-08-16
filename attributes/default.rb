# This version must be compatible with ruby-install definitions
default['ruby']['version']      = '2.1.5'
default['ruby']['prefix_path']  = '/usr/local'
default['ruby']['flavor']       = 'ruby'

# Override ruby install attributes to get latest version
node.set['ruby_install']['version'] = '0.5.0'
node.set['ruby_install']['checksum'] = 'aa4448c2c356510cc7c2505961961a17bd3f3435842831e04c8516eb703afd19'

case node['platform_family']
when 'debian', 'ubuntu'
  default['ruby']['required_pkgs'] =
    %w{ build-essential bison openssl libreadline6 libreadline6-dev
        zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0
        libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf
        ssl-cert libffi-dev cmake }
end
