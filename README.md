# Ruby Cookbook

This cookbook will install the most recent ruby version system-wide
by compiling from the source using (ruby-build)[https://github.com/sstephenson/ruby-build].

While ruby-build is a rbenv plugin, it can be used standalone without
effort.

# Requirements

We use the awesome (chef-ruby_build)[https://github.com/fnichol/chef-ruby_build] recipe to invoke ruby-build

# Usage

Upload chef-ruby_build and this cookbook to your chef server and
customize the attributes if you need.

# Attributes

* `node['ruby']['version']` - Version must be compatible with ruby-build, Ex: '2.0.0-p353' (default)
* `node['ruby']['prefix_path']` - We are using /usr/local as a way to make it work even with sudo command

# Author

Author:: Gabriel Mazetto (<brodock@gmail.com>)
