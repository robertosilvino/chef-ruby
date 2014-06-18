# Ruby Cookbook

This cookbook will install the most recent ruby version system-wide
by compiling from the source using (ruby-install)[https://github.com/postmodern/ruby-install].

While ruby-build is a rbenv plugin, it can be used standalone without
effort.

# Requirements

We use the (chef-ruby_install)[https://github.com/rosstimson/chef-ruby_install.git] recipe to install ruby-install
and invoke it by our own LWRP.

# Usage

Upload chef-ruby_install and this cookbook to your chef server and
customize the attributes if you need.

# Attributes

* `node['ruby']['version']` - Version must be compatible with ruby-build, Ex: '2.0.0-p353' (default)
* `node['ruby']['prefix_path']` - We are using /usr/local as a way to make it work even with sudo command

# Author

Author:: Gabriel Mazetto (<brodock@gmail.com>)
