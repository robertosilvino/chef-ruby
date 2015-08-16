require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

action :install do
  if ruby_installed? && !should_upgrade_ruby?
    Chef::Log.info("ruby_install: #{@ruby_flavor} #{@ruby_version} is already installed, so skipping")
  else
    execute_ruby_install(@ruby_flavor, @ruby_version, @prefix_path)
    new_resource.updated_by_last_action(true)
  end
end

action :reinstall do
  execute_ruby_install(@ruby_flavor, @ruby_version, @prefix_path)
  new_resource.updated_by_last_action(true)
end

def load_current_resource
  @definition   = new_resource.definition
  @ruby_version = new_resource.version      || node['ruby']['version']
  @prefix_path  = new_resource.prefix_path  || node['ruby']['prefix_path']
  @ruby_flavor  = new_resource.flavor       || node['ruby']['flavor']
end

private

def execute_ruby_install(ruby_flavor, ruby_version, prefix_path)
  install_start = Time.now
  Chef::Log.info("Building ruby_install: #{ruby_flavor} #{ruby_version}, this could take a while...")

  execute "ruby-install[#{ruby_version}]" do
    command   %( /usr/local/bin/ruby-install -i "#{prefix_path}" #{ruby_flavor} "#{ruby_version}" )
    action    :nothing
  end.run_action(:run)

  Chef::Log.info("ruby_install: #{ruby_flavor} #{ruby_version} - build time was "\
    "#{(Time.now - install_start) / 60.0} minutes")
end

def ruby_installed?
  ::File.exists?(ruby_interpreter_full_path)
end

def should_upgrade_ruby?
  cmd = "#{ruby_interpreter_full_path} -e " + %q('puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"')
  out = Mixlib::ShellOut.new(cmd)
  out.run_command

  version_installed = out.stdout.chomp
  version_match = !!(/^#{@ruby_version}/ =~ version_installed)

  Chef::Log.info("ruby_install: found #{@ruby_flavor} #{version_installed} installed")

  out.stderr.empty? && !version_match
end

def ruby_interpreter_full_path
  case @ruby_flavor
  when 'ruby'
    "#{@prefix_path}/bin/ruby"
  when 'rbx'
    "#{@prefix_path}/bin/rbx"
  when 'jruby'
    "#{@prefix_path}/bin/jruby"
  else
    Chef::Log.warn("ruby_install: #{@ruby_flavor} #{@ruby_version} is not a supported ruby flavor")
    "#{@prefix_path}/bin/ruby" # best guess
  end
end
