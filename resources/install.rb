actions :install, :reinstall
default_action :install

attribute :definition,  kind_of: String, name_attribute: true
attribute :flavor,      kind_of: String
attribute :prefix_path, kind_of: String
